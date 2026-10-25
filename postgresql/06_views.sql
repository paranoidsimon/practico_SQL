-- primera vista
CREATE VIEW VW_PRESTAMOS_DETALLE AS
SELECT p.fecha_prestamo, 
CONCAT(e.nombres, ' ', e.apellidos) AS nombre_estudiante, 
l.titulo, 
CONCAT(f.nombres, ' ', f.apellidos) AS nombre_funcionario,
c.nombre AS nombre_carrera
FROM prestamos p
JOIN estudiantes e ON p.dni_est = e.dni_est
JOIN carreras c ON e.id_carrera = c.id_carrera
JOIN libros l ON p.cod_libro = l.cod_libro
JOIN funcionarios f ON p.dni_funcionario = f.dni_funcionario;


-- segunda vista
CREATE VIEW VW_LIBROS_POR_BIBLIOTECA AS
SELECT b.nombre AS nombre_biblioteca, COUNT(l.cod_libro) AS cantidad_libros
FROM bibliotecas b
LEFT JOIN libros l ON b.id_biblioteca = l.id_biblioteca
GROUP BY b.id_biblioteca, b.nombre;