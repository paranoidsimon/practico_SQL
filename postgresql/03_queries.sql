--CONSULTA 1
SELECT titulo, anio
FROM libros
ORDER BY anio ASC;

--CONSULTA 2
SELECT nombres, apellidos, edad
FROM estudiantes
WHERE edad > 25;

--CONSULTA 3
SELECT titulo, anio
FROM libros
WHERE id_editorial = 3;

--CONSULTA 4
SELECT *
FROM autores a
WHERE a.apellido LIKE 'M%';

--CONSULTA 5
SELECT nombres, apellidos, salud
FROM funcionarios
WHERE salud NOT LIKE 'Buena';

--CONSULTA 6
SELECT l.titulo, a.nombre, a.apellido
FROM libros l
JOIN autores a ON l.id_autor = a.id_autor;

--CONSULTA 7
SELECT p.fecha_prestamo,  CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante , l.titulo, CONCAT(f.nombres,' ' ,f.apellidos) AS nombre_funcionario
FROM prestamos p
JOIN estudiantes e ON p.dni_est = e.dni_est
JOIN libros l ON p.cod_libro = l.cod_libro
JOIN funcionarios f ON p.dni_funcionario = f.dni_funcionario;

--CONSULTA 8
SELECT CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante, car.nombre AS nombre_carrera, ci.nombre AS nombre_ciudad
FROM estudiantes e
JOIN carreras car ON e.id_carrera = car.id_carrera
JOIN campus cam ON car.id_campus = cam.id_campus
JOIN ciudades ci ON cam.id_ciudad = ci.id_ciudad;

--CONSULTA 9
SELECT l.titulo, e.nombre AS nombre_editorial, e.pais
FROM libros l
JOIN editoriales e ON l.id_editorial = e.id_editorial;

--CONSULTA 10
SELECT l.titulo, b.nombre AS biblioteca_fisica
FROM libros l
JOIN bibliotecas b ON l.id_biblioteca = b.id_biblioteca;

--CONSULTA 11
SELECT t.nombre AS tipo_libro, COUNT(l.cod_libro) AS cantidad_libros
FROM tipo t
LEFT JOIN libros l ON t.id_tipo = l.id_tipo
GROUP BY t.nombre;

--CONSULTA 12
SELECT c.nombre AS nombre_carrera, AVG(e.edad) AS edad_promedio
FROM estudiantes e
JOIN carreras c ON e.id_carrera = c.id_carrera
GROUP BY c.nombre;

--CONSULTA 13
SELECT f.nombres, f.apellidos, COUNT(p.id_prestamo) AS cantidad_prestamos
FROM funcionarios f
JOIN prestamos p ON f.dni_funcionario = p.dni_funcionario
GROUP BY f.nombres, f.apellidos;

--CONSULTA 14 (aunque no lo pedia, en la consulta se muestra la cantidad de libros por autor)
SELECT a.nombre, a.apellido, COUNT(l.cod_libro) AS cantidad_libros
FROM autores a
JOIN libros l ON a.id_autor = l.id_autor
GROUP BY a.nombre, a.apellido
HAVING COUNT(l.cod_libro) > 1;

--CONSULTA 15
SELECT c.nombre AS nombre_ciudad, COUNT(e.dni_est) AS cantidad_estudiantes
FROM estudiantes e
JOIN carreras car ON e.id_carrera = car.id_carrera
JOIN campus cam ON car.id_campus = cam.id_campus
JOIN ciudades c ON cam.id_ciudad = c.id_ciudad 
GROUP BY c.nombre;

--CONSULTA 16
SELECT l.titulo, l.anio
FROM libros l
ORDER BY l.anio ASC
LIMIT 1;

--CONSULTA 16 ALTERNATIVA - si hay varios libros con el mismo año los devuelve a todos y no se limita a uno solo
SELECT titulo, anio
FROM libros
WHERE anio = (SELECT MIN(anio) FROM libros);

--CONSULTA 17
SELECT CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante
FROM estudiantes e
LEFT JOIN prestamos p on e.dni_est = p.dni_est
WHERE p.dni_est IS NULL;

--CONSULTA 18
SELECT l.titulo
FROM libros l
LEFT JOIN prestamos p ON l.cod_libro = p.cod_libro
WHERE p.cod_libro IS NULL;

--CONSULTA 19
SELECT *
FROM prestamos
WHERE fecha_prestamo >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
  AND fecha_prestamo <  date_trunc('month', CURRENT_DATE);


--CONSULTA 19 ALTERNATIVA - mostrando nombres de estudiante, libro y funcionario
SELECT p.fecha_prestamo, CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante, l.titulo, CONCAT(f.nombres,' ' ,f.apellidos) AS nombre_funcionario
FROM prestamos p
JOIN estudiantes e ON p.dni_est = e.dni_est
JOIN libros l ON p.cod_libro = l.cod_libro
JOIN funcionarios f ON p.dni_funcionario = f.dni_funcionario
WHERE p.fecha_prestamo >= date_trunc('month', CURRENT_DATE) - INTERVAL '1 month'
  AND p.fecha_prestamo <  date_trunc('month', CURRENT_DATE);

--CONSULTA 20
SELECT l.titulo, COUNT(p.id_prestamo) AS cantidad_prestamos
FROM libros l
JOIN prestamos p ON l.cod_libro = p.cod_libro
GROUP BY l.titulo
ORDER BY cantidad_prestamos DESC
LIMIT 3;

