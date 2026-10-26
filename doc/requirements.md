# Modelo de datos: Sistema de Préstamos de Biblioteca Universitaria

## 1. Descripción general

### 1.1 De qué se trata

El modelo representa la gestión de una **biblioteca universitaria distribuida en varios campus**. Permite registrar:

- Qué **estudiantes** pertenecen a qué **carrera**, y en qué **campus** y **ciudad** se dicta.
- Qué **funcionarios** trabajan en cada campus y atienden los préstamos.
- El **catálogo de libros**, con su autor, editorial, tipo y biblioteca donde se encuentran físicamente.
- Los **préstamos** que se realizan: qué estudiante pidió qué libro, qué funcionario lo atendió y en qué fechas.

### 1.2 Qué representa cada tabla

| Tabla | Representa | Clave primaria |
|---|---|---|
| `CIUDAD` | Ciudades donde existen campus | `ID_CIUDAD` |
| `CAMPUS` | Sedes de la universidad | `ID_CAMPUS` |
| `CARRERAS` | Carreras que se dictan en un campus | `ID_CARRERA` |
| `ESTUDIANTES` | Alumnos que pueden pedir libros | `RUT_EST` |
| `FUNCIONARIOS` | Personal que atiende los préstamos | `RUT_FUNC` |
| `AUTORES` | Autores de los libros | `RUT_AUTOR` |
| `EDITORIALES` | Editoriales y su país de origen | `ID_EDIT` |
| `TIPO` | Clasificación del libro (novela, poesía, etc.) | `ID_TIPO` |
| `BIBLIOTECA` | Biblioteca física donde se guarda el libro | `ID_BIBLIO` |
| `LIBROS` | Catálogo de libros | `COD_LIBRO` |
| `PRESTAMO` | Registro de cada préstamo | `(RUT_EST, RUT_FUNC, COD_LIBRO)` |

### 1.3 Estructura en capas

- **Capa geográfica y académica:** `CIUDAD → CAMPUS → CARRERAS → ESTUDIANTES`, y `CAMPUS → FUNCIONARIOS`.
- **Capa de catálogo:** `LIBROS`, que depende de `AUTORES`, `EDITORIALES`, `TIPO` y `BIBLIOTECA`.
- **Capa transaccional:** `PRESTAMO`, que une estudiantes, funcionarios y libros.

---

## 2. Relaciones y sus inversas

La **relación directa** sigue el sentido de la clave foránea (de la tabla que la contiene hacia la tabla referenciada). La **relación inversa** se lee en sentido contrario.

| # | Relación directa | Relación inversa | Cardinalidad | Clave foránea |
|---|---|---|---|---|
| 1 | Un **campus** está ubicado en una **ciudad** | Una **ciudad** tiene muchos **campus** | N : 1 | `CAMPUS.ID_CIUDAD` |
| 2 | Una **carrera** se dicta en un **campus** | Un **campus** ofrece muchas **carreras** | N : 1 | `CARRERAS.ID_CAMPUS` |
| 3 | Un **estudiante** pertenece a una **carrera** | Una **carrera** tiene muchos **estudiantes** | N : 1 | `ESTUDIANTES.ID_CARRERA` |
| 4 | Un **funcionario** trabaja en un **campus** | Un **campus** tiene muchos **funcionarios** | N : 1 | `FUNCIONARIOS.ID_CAMPUS` |
| 5 | Un **libro** es de un **autor** | Un **autor** escribió muchos **libros** | N : 1 | `LIBROS.RUT_AUTOR` |
| 6 | Un **libro** lo publica una **editorial** | Una **editorial** publica muchos **libros** | N : 1 | `LIBROS.ID_EDIT` |
| 7 | Un **libro** es de un **tipo** | Un **tipo** agrupa muchos **libros** | N : 1 | `LIBROS.ID_TIPO` |
| 8 | Un **libro** está en una **biblioteca** | Una **biblioteca** contiene muchos **libros** | N : 1 | `LIBROS.ID_BIBLIO` |
| 9 | Un **préstamo** lo solicita un **estudiante** | Un **estudiante** puede tener muchos **préstamos** | N : 1 | `PRESTAMO.RUT_EST` |
| 10 | Un **préstamo** lo atiende un **funcionario** | Un **funcionario** atiende muchos **préstamos** | N : 1 | `PRESTAMO.RUT_FUNC` |
| 11 | Un **préstamo** es de un **libro** | Un **libro** puede estar en muchos **préstamos** | N : 1 | `PRESTAMO.COD_LIBRO` |

### Relación muchos a muchos resuelta

`ESTUDIANTES` y `LIBROS` tienen una relación **N : M** (un estudiante pide muchos libros y un libro es pedido por muchos estudiantes). Se resuelve con la **tabla intermedia `PRESTAMO`**, que además incorpora al funcionario y los atributos propios del préstamo (`FECHA_P`, `FECHA_E`).

### Observación sobre la clave compuesta

Con la clave `(RUT_EST, RUT_FUNC, COD_LIBRO)`, la misma combinación estudiante, funcionario y libro solo puede registrarse **una vez**. Si el estudiante pide el mismo libro de nuevo, atendido por el mismo funcionario, la base lo rechaza. Una alternativa es agregar una clave artificial (`ID_PRESTAMO`) o incluir `FECHA_P` en la clave.

---

## 3. Requerimientos funcionales

### 3.1 Gestión de datos maestros

- **RF-01.** El sistema debe permitir registrar, consultar, modificar y eliminar **ciudades**, **campus** y **carreras**.
- **RF-02.** El sistema debe permitir registrar **estudiantes** con nombres, apellidos, edad, teléfono, dirección y carrera asignada.
- **RF-03.** El sistema debe permitir registrar **funcionarios** con nombres, apellidos, edad, dirección, estado de salud y campus asignado.
- **RF-04.** El sistema debe permitir gestionar el **catálogo de libros** con título, año, tipo, autor, editorial y biblioteca de ubicación.
- **RF-05.** El sistema debe permitir gestionar **autores**, **editoriales** (con su país), **tipos** de libro y **bibliotecas**.

### 3.2 Gestión de préstamos

- **RF-06.** El sistema debe permitir registrar un **préstamo** asociando un estudiante, un libro y el funcionario que lo atiende.
- **RF-07.** El sistema debe guardar la **fecha de préstamo** y la **fecha de entrega o devolución** de cada préstamo.
- **RF-08.** El sistema debe verificar, antes de registrar un préstamo, que el **libro no esté ya prestado** (procedimiento `SP_REGISTRAR_PRESTAMO`).
- **RF-09.** El sistema debe mostrar un **mensaje de confirmación** cuando el préstamo se registra correctamente.
- **RF-10.** El sistema debe impedir registrar préstamos con estudiantes, funcionarios o libros que **no existan**.

### 3.3 Consultas y reportes

- **RF-11.** El sistema debe listar libros con sus autores, editoriales, tipos y bibliotecas.
- **RF-12.** El sistema debe mostrar el detalle de los préstamos con nombres legibles (vista `VW_PRESTAMOS_DETALLE`): fecha, estudiante, libro, funcionario y carrera.
- **RF-13.** El sistema debe informar la **cantidad de libros por biblioteca y ciudad** (vista `VW_LIBROS_POR_BIBLIOTECA`).
- **RF-14.** El sistema debe permitir obtener estadísticas: libros por tipo, edad promedio por carrera, préstamos por funcionario, estudiantes por ciudad y los libros más prestados.
- **RF-15.** El sistema debe permitir identificar **estudiantes que nunca pidieron un libro** y **libros nunca prestados**.
- **RF-16.** El sistema debe permitir consultar los **préstamos del mes anterior**.

### 3.4 Reglas de negocio y automatización

- **RF-17.** Al registrar un préstamo, el sistema debe dejar un registro en `AUDITORIA_PRESTAMOS` con el estudiante, el libro, la fecha y hora, y la acción "NUEVO PRÉSTAMO" (trigger `TR_AUDITAR_PRESTAMO`).
- **RF-18.** El sistema debe **rechazar** el alta o modificación de estudiantes con edad menor a 17 años, mostrando un mensaje de error (trigger `TR_VALIDAR_EDAD_ESTUDIANTE`).
- **RF-19.** El sistema debe impedir **borrar** carreras con estudiantes asociados, libros con préstamos asociados, y en general cualquier registro referenciado por otro.

### 3.5 Usuarios y permisos

- **RF-20.** El sistema debe contar con un usuario **bibliotecario** con permisos de solo lectura sobre `LIBROS`, `AUTORES` y `EDITORIALES`, y de lectura y escritura sobre `PRESTAMO`.
- **RF-21.** El sistema debe contar con un usuario **administrador** con todos los privilegios sobre la base de datos.
- **RF-22.** El sistema debe permitir **revocar** permisos puntuales (por ejemplo, `DELETE` sobre `PRESTAMO` al bibliotecario).

---

## 4. Requerimientos no funcionales

### 4.1 Integridad y consistencia

- **RNF-01. Integridad referencial:** todas las relaciones deben implementarse con claves foráneas, de modo que no existan registros huérfanos.
- **RNF-02. Integridad de entidad:** cada tabla debe tener una clave primaria única y no nula.
- **RNF-03. Integridad de dominio:** los datos deben validarse por tipo y rango (por ejemplo, edad positiva y mayor o igual a 17, fecha de entrega no anterior a la de préstamo).
- **RNF-04. Orden de creación:** el esquema debe poder crearse respetando las dependencias (`CIUDAD` → `CAMPUS` → `CARRERAS` → `ESTUDIANTES`, etc.).
- **RNF-05. Normalización:** el diseño debe evitar redundancia (autores, editoriales, tipos y bibliotecas en tablas separadas), al menos hasta la **tercera forma normal**.

### 4.2 Seguridad

- **RNF-06. Control de acceso:** el acceso debe regirse por el principio de **mínimo privilegio**, con roles diferenciados (bibliotecario y administrador).
- **RNF-07. Contraseñas:** los usuarios deben tener contraseñas seguras.
- **RNF-08. Protección de datos personales:** los datos de estudiantes y funcionarios (teléfono, dirección, salud) deben ser accesibles solo a quienes los necesiten.

### 4.3 Auditoría y trazabilidad

- **RNF-09. Auditoría:** las altas de préstamos deben quedar registradas automáticamente, con fecha y hora del sistema.
- **RNF-10. Trazabilidad:** debe poder reconstruirse quién pidió qué libro, quién lo atendió y cuándo.

### 4.4 Rendimiento

- **RNF-11. Índices:** las columnas usadas frecuentemente en uniones y filtros (claves foráneas, fechas de préstamo) deben estar indexadas.
- **RNF-12. Consultas eficientes:** los reportes habituales (préstamos por mes, libros más prestados) deben resolverse sin recorrer toda la base cuando sea posible.

### 4.5 Mantenibilidad y portabilidad

- **RNF-13. Nomenclatura consistente:** nombres de tablas y columnas coherentes, en minúsculas y sin espacios.
- **RNF-14. Abstracción mediante vistas:** la información de uso frecuente debe exponerse mediante vistas, para no repetir consultas complejas.
- **RNF-15. Reutilización:** la lógica de negocio repetitiva debe encapsularse en procedimientos almacenados y triggers.
- **RNF-16. Portabilidad:** el script debe documentar las diferencias de sintaxis entre motores (por ejemplo, `AUTO_INCREMENT` de MySQL frente a `SERIAL` de PostgreSQL).

### 4.6 Disponibilidad y recuperación

- **RNF-17. Respaldo:** debe ser posible respaldar y restaurar la base completa.
- **RNF-18. Datos de prueba:** debe existir un conjunto de datos suficiente para que cada consulta del trabajo práctico devuelva al menos un resultado.

---

## 5. Supuestos y observaciones del modelo

- El modelo no relaciona a `ESTUDIANTES` con una ciudad directamente: la **ciudad donde estudia** se deduce por `ESTUDIANTES → CARRERAS → CAMPUS → CIUDAD`.
- La relación `PRESTAMO → LIBROS` no impide por sí sola que un mismo libro tenga varios préstamos simultáneos. Esa restricción debe implementarse en el procedimiento `SP_REGISTRAR_PRESTAMO`.

---

## 6. Decisiones de implementación y diferencias con el diagrama

Esta sección resume lo que se resolvió de forma distinta al diagrama original al implementar el modelo en **PostgreSQL**, y por qué.

### 6.1 Cambios en la estructura

| Elemento | En el diagrama | En la implementación | Motivo |
|---|---|---|---|
| Clave de `PRESTAMO` | PK compuesta `(RUT_EST, RUT_FUNC, COD_LIBRO)` | Clave artificial `id_prestamo` (`SERIAL`); las tres columnas quedan como FK | Permite que el mismo estudiante pida el mismo libro más de una vez |
| Identificador de personas | `RUT_EST`, `RUT_FUNC` | `dni_est`, `dni_funcionario` | Se adaptó el modelo a Argentina, donde se usa DNI en lugar de RUT |
| Identificador de autores | `RUT_AUTOR` | `id_autor` (numérico autogenerado) | Un identificador numérico es más simple y estable |
| Identificador de biblioteca y editorial | `ID_BIBLIO`, `ID_EDIT` | `id_biblioteca`, `id_editorial` | Nombres más descriptivos y consistentes |
| Fechas del préstamo | `FECHA_P`, `FECHA_E` | `fecha_prestamo`, `fecha_devolucion` | Nombres más claros; la devolución admite `NULL` mientras el libro no se devuelve |
| Nombres de tablas | `PRESTAMO`, `CIUDAD`, `BIBLIOTECA` | `prestamos`, `ciudades`, `bibliotecas` | Se usó plural y minúsculas de forma consistente |
| Tabla de auditoría | No figura en el diagrama | `auditoria_prestamos` | La exige la sección de triggers del trabajo práctico |

### 6.2 Adaptaciones por el motor (PostgreSQL)

- **Triggers:** PostgreSQL no permite escribir el cuerpo dentro del `CREATE TRIGGER`. Cada trigger se implementa en dos pasos: una función con `RETURNS TRIGGER` y el trigger que la invoca.
- **Mensajes de error:** en lugar de `SIGNAL SQLSTATE` (MySQL) se usa `RAISE EXCEPTION`.
- **Autoincremental:** se usa `SERIAL` en lugar de `AUTO_INCREMENT`.
- **Procedimiento almacenado:** se crea con `CREATE PROCEDURE` y se ejecuta con `CALL`; el mensaje de éxito se muestra con `RAISE NOTICE`.
- **Usuarios y permisos:** el usuario se crea con `CREATE USER` y no lleva `@localhost`, porque en PostgreSQL el origen de la conexión se controla aparte. Para poder registrar préstamos, el bibliotecario necesita además permisos sobre las secuencias de `id_prestamo` y `auditoria_prestamos`.
- **Orden de creación:** las tablas se crean respetando las dependencias (`ciudades` → `campus` → `carreras` → `estudiantes`, y las tablas de catálogo antes de `libros` y `prestamos`).

### 6.3 Limitaciones del modelo que se mantienen

- **`BIBLIOTECA` sin ubicación:** no se relaciona con `CAMPUS` ni con `CIUDAD`, por lo que la vista de libros por biblioteca no puede mostrar la ciudad, y solo muestra el nombre y la cantidad de libros.
- **Un solo autor por libro:** `LIBROS` tiene una única clave foránea hacia `AUTORES`, así que no se pueden representar libros con varios autores sin una tabla intermedia.
- **Sin control de ejemplares:** el modelo no tiene un campo de cantidad (stock), por lo que cada código de libro representa un único ejemplar.
- **Ciudad del estudiante:** `ESTUDIANTES` no tiene ciudad propia; la ciudad donde estudia se deduce a través de su carrera y su campus.
