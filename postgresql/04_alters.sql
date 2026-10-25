-- insertar estudiante nuevo
INSERT INTO estudiantes (dni_est, nombres, apellidos, edad, telefono, direccion, id_carrera)
VALUES ('42555777', 'Lautaro', 'Medina Paz', 21, '+5491155550006', 'Calle Mitre 350, Buenos Aires', 1);

-- actualizar salud de un funcionario
UPDATE funcionarios
SET salud = 'Excelente'
WHERE edad > 50;

--eliminar un libro especifico
DELETE FROM libros
WHERE cod_libro = 'LIB-016';

--cambio de editorial
UPDATE libros
SET id_editorial = 4
WHERE cod_libro = 'LIB-017';