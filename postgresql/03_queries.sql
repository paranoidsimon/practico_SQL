--CONSULTA 1
SELECT titulo, anio
FROM libros
ORDER BY anio ASC;

--CONSULTA 2
SELECT nombres, apellidos, edad
FROM estudiantes
WHERE edad > 25

--CONSULTA 3
SELECT titulo, anio
FROM libros
WHERE id_editorial = 3

--CONSULTA 4
SELECT *
FROM autores a
WHERE a.apellido LIKE 'M%'

--CONSULTA 5
SELECT nombres, apellidos, salud
FROM funcionarios
WHERE salud NOT LIKE 'Buena'

--CONSULTA 6
SELECT l.titulo, a.nombre, a.apellido
FROM libros l
JOIN autores a ON l.id_autor = a.id_autor

--CONSULTA 7
SELECT p.fecha_prestamo,  CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante , l.titulo, CONCAT(f.nombres,' ' ,f.apellidos) AS nombre_funcionario
FROM prestamos p
JOIN estudiantes e ON p.dni_est = e.dni_est
JOIN libros l ON p.cod_libro = l.cod_libro
JOIN funcionarios f ON p.dni_funcionario = f.dni_funcionario

--CONSULTA 8
SELECT CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante, ca.nombre AS nombre_carrera, ci.nombre AS nombre_ciudad
FROM estudiantes e
JOIN carreras car ON e.id_carrera = car.id_carrera
JOIN campus cam ON car.id_campus = cam.id_campus
JOIN ciudades ci ON cam.id_ciudad = ci.id_ciudad;