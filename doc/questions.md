# Trabajo Práctico N° 1 SQL | Base de Datos

## Sección 8 — Preguntas teóricas

> **Modelo de referencia:** sistema de préstamos de libros de una biblioteca universitaria.
> Tablas: `ESTUDIANTES`, `FUNCIONARIOS`, `CARRERAS`, `CAMPUS`, `CIUDAD`, `LIBROS`, `AUTORES`, `EDITORIALES`, `BIBLIOTECA`, `TIPO` y `PRESTAMO`.

---

## Índice

1. [Clave primaria compuesta en `PRESTAMO`](#1-clave-primaria-compuesta-en-prestamo)
2. [Borrado de una `CARRERA` con estudiantes asociados](#2-borrado-de-una-carrera-con-estudiantes-asociados)
3. [Autor en una tabla separada](#3-autor-en-una-tabla-separada)
4. [Relación entre `CAMPUS` y `CIUDAD`](#4-relación-entre-campus-y-ciudad)

---

## 1. Clave primaria compuesta en `PRESTAMO`

**Pregunta:** ¿Por qué la tabla `PRESTAMO` tiene una clave primaria compuesta (PK, FK1, FK2, FK3)? ¿Qué pasaría si un estudiante quisiera pedir el mismo libro dos veces? ¿Cómo se maneja esa situación en la vida real vs. en este modelo?

### Respuesta

**¿Por qué una clave compuesta?**

`PRESTAMO` es una **tabla intermedia**: resuelve la relación muchos a muchos entre `ESTUDIANTES` y `LIBROS` (un estudiante pide muchos libros y un libro lo piden muchos estudiantes), e incorpora al funcionario que atiende. No tiene un identificador propio, así que su identidad se forma con las claves de las tres tablas que conecta:

- `RUT_EST` → PK y FK hacia `ESTUDIANTES`
- `RUT_FUNC` → PK y FK hacia `FUNCIONARIOS`
- `COD_LIBRO` → PK y FK hacia `LIBROS`

Cada columna es **FK** porque apunta a otra tabla, y las tres juntas son la **PK** porque identifican de forma única cada fila.

**¿Qué pasaría si el estudiante pide el mismo libro dos veces?**

La base lo **rechaza**, siempre que lo atienda el mismo funcionario. La combinación `(RUT_EST, RUT_FUNC, COD_LIBRO)` ya existe, y PostgreSQL responde con un error de clave duplicada:

```
ERROR: duplicate key value violates unique constraint "prestamo_pkey"
```

Si lo atendiera otro funcionario, la combinación sería distinta y sí se aceptaría. Eso muestra que la clave no está bien pensada para el caso.

**Vida real vs. este modelo**

| | Vida real | Este modelo |
|---|---|---|
| Mismo estudiante, mismo libro, otra fecha | Es normal: cada préstamo es un evento distinto | Da error de clave duplicada |
| Identificación del préstamo | Un número o comprobante propio | La combinación de tres claves |
| Historial | Se conservan todos los préstamos | Solo uno por combinación |

**Limitación del modelo y cómo se resuelve**

El diseño original no permite guardar el historial completo de préstamos repetidos. Hay dos soluciones habituales:

1. **Agregar la fecha a la clave:** `PRIMARY KEY (rut_est, rut_func, cod_libro, fecha_p)`.
2. **Usar una clave artificial** (la opción más común): agregar `id_prestamo SERIAL PRIMARY KEY` y dejar las otras tres como FK normales.

En la implementación de este trabajo se usó la segunda, así el mismo estudiante puede pedir el mismo libro muchas veces.

**Otra limitación:** el modelo no tiene un campo de cantidad (stock), así que cada `COD_LIBRO` representa un único ejemplar. Por eso el procedimiento `SP_REGISTRAR_PRESTAMO` debe verificar que el libro no esté ya prestado.

---

## 2. Borrado de una `CARRERA` con estudiantes asociados

**Pregunta:** Si intentamos borrar una `CARRERA` que tiene estudiantes asociados, ¿qué debería hacer la base de datos? ¿Por qué?

### Respuesta

**Debería rechazar el borrado** y devolver un error de clave foránea, sin eliminar nada:

```
ERROR: update or delete on table "carreras" violates foreign key constraint
       "estudiantes_id_carrera_fkey" on table "estudiantes"
```

**¿Por qué?**

Por la **integridad referencial**: `ESTUDIANTES.ID_CARRERA` es una clave foránea que apunta a `CARRERAS`. Si se borrara la carrera, los estudiantes quedarían apuntando a una carrera que ya no existe (**registros huérfanos**), y consultas como "nombre del estudiante, su carrera y su ciudad" perderían filas o mostrarían datos incorrectos.

**Alternativas del motor**

| Opción | Qué hace | ¿Sirve acá? |
|---|---|---|
| `RESTRICT` / `NO ACTION` (por defecto) | Impide el borrado | **Sí**, es la más segura |
| `CASCADE` | Borra también a los estudiantes de esa carrera | No: es peligroso y fallaría igual por los préstamos asociados |
| `SET NULL` | Deja `ID_CARRERA` en nulo | No: la columna es `NOT NULL` y un estudiante sin carrera no tiene sentido |

**¿Cómo se borra entonces?**

Primero hay que reasignar o eliminar a sus estudiantes y recién después borrar la carrera. Si se quiere conservar el historial, una alternativa es el **borrado lógico** (`is_deleted = TRUE`), que oculta la carrera sin eliminarla.

---

## 3. Autor en una tabla separada

**Pregunta:** Observando la tabla `LIBROS`, ¿por qué crees que el autor está en una tabla separada (`AUTORES`) y no directamente en la tabla de libros?

### Respuesta

Por la **normalización**: un autor puede tener muchos libros, y si sus datos estuvieran en `LIBROS`, se repetirían en cada uno.

**Problemas que se evitan**

- **Redundancia:** el nombre y apellido de *Borges* se guardarían en cada una de sus obras.
- **Anomalía de actualización:** corregir un apellido obligaría a modificar muchas filas, con riesgo de dejar versiones distintas del mismo autor.
- **Anomalía de inserción:** no se podría registrar un autor sin cargar antes un libro suyo.
- **Anomalía de borrado:** al borrar su único libro, se perderían también los datos del autor.

**Ventajas de la tabla separada**

- Los datos del autor se guardan **una sola vez** y `LIBROS` solo guarda la referencia (`RUT_AUTOR`).
- Se simplifican consultas como "autores con más de un libro" o "autores cuyo apellido empieza con M".
- Es el mismo criterio que se aplica a `EDITORIALES`, `TIPO` y `BIBLIOTECA`.

**Limitación del modelo**

Como `LIBROS` tiene **un solo** `RUT_AUTOR`, cada libro puede tener un único autor. Un libro con varios autores no se puede representar sin agregar una tabla intermedia `LIBROS_AUTORES`.

---

## 4. Relación entre `CAMPUS` y `CIUDAD`

**Pregunta:** ¿Qué tipo de relación existe entre `CAMPUS` y `CIUDAD` (Uno a Muchos, Muchos a Muchos, etc.)? Justifica.

### Respuesta

Es una relación **uno a muchos (1:N)** desde `CIUDAD` hacia `CAMPUS`.

**Justificación**

- Una **ciudad** puede tener **varios campus**. Por ejemplo, Buenos Aires tiene Campus Central y Campus Norte.
- Un **campus** pertenece a **una sola ciudad**.

**Cómo se implementa**

La relación se materializa con la clave foránea `ID_CIUDAD` en la tabla `CAMPUS`, que apunta a `CIUDAD.ID_CIUDAD`. La FK siempre va en el lado "muchos".

**Relación inversa**

Vista desde `CAMPUS`, es **muchos a uno (N:1)**: muchos campus pertenecen a una ciudad.

**Por qué no es muchos a muchos**

Un campus es una sede física y no puede estar en dos ciudades a la vez, así que no se necesita una tabla intermedia.

**Limitaciones relacionadas del modelo**

- `ESTUDIANTES` no tiene ciudad propia: la "ciudad donde estudia" se obtiene recorriendo `ESTUDIANTES → CARRERAS → CAMPUS → CIUDAD`.
- `BIBLIOTECA` no se relaciona con `CAMPUS` ni con `CIUDAD`, por lo que la vista `VW_LIBROS_POR_BIBLIOTECA` no puede mostrar la ciudad, salvo que se modifique el modelo.
