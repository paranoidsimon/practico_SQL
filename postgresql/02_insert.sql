INSERT INTO ciudades (nombre) VALUES
('Buenos Aires'), ('Córdoba'), ('Rosario'), ('Mendoza');

INSERT INTO campus (nombre, id_ciudad) VALUES
('Campus Central', 1),
('Campus Norte',   1),
('Campus Córdoba', 2),
('Campus Rosario', 3),
('Campus Cuyo',    4);

INSERT INTO carreras (nombre, id_campus) VALUES
('Ingeniería en Sistemas de Información', 1),
('Medicina',                              2),
('Abogacía',                              1),
('Licenciatura en Psicología',            4),
('Arquitectura',                          4),
('Licenciatura en Administración',        3),
('Licenciatura en Enfermería',            5),
('Profesorado en Historia',               5);

INSERT INTO estudiantes (rut_est, nombres, apellidos, edad, telefono, direccion, id_carrera) VALUES
('40123456', 'Camila',    'Rojas Pérez',     21, '+5491155551111', 'Av. Corrientes 1234, Buenos Aires',   1),
('38876543', 'Matías',    'González Soto',   23, '+5491155552222', 'Calle Defensa 45, Buenos Aires',      1),
('41034567', 'Valentina', 'Muñoz Díaz',      20, '+5493515553333', 'Bv. San Juan 780, Córdoba',           2),
('40456789', 'Sebastián', 'Soto Contreras',  22, '+5491155554444', 'Av. Santa Fe 1200, Buenos Aires',     3),
('37654321', 'Florencia', 'Vargas Lagos',    24, '+5493415555555', 'Calle Córdoba 345, Rosario',          4),
('42345678', 'Benjamín',  'Silva Araya',     19, '+5493415556666', 'Av. Pellegrini 90, Rosario',          5),
('40234567', 'Julieta',   'Fuentes Navarro', 22, '+5493515557777', 'Calle Obispo Trejo 567, Córdoba',     6),
('38987654', 'Diego',     'Castillo Reyes',  25, '+5492615558888', 'Av. San Martín 1020, Mendoza',        7),
('40567890', 'Agustina',  'Herrera Mora',    21, '+5492615559999', 'Calle Las Heras 230, Mendoza',        8),
('41123456', 'Tomás',     'Ortiz Bravo',     20, '+5491155550001', 'Av. Rivadavia 450, Buenos Aires',     2),
('40345678', 'Catalina',  'Núñez Vera',      23, '+5491155550002', 'Calle Lavalle 88, Buenos Aires',      3),
('36765432', 'Nicolás',   'Pizarro Gil',     26, '+5493415550003', 'Av. Alberdi 1500, Rosario',           1),
('39111222', 'Lucía',     'Benítez Ruiz',    27, '+5491155550004', 'Calle Tucumán 700, Buenos Aires',     2),
('41222333', 'Martín',    'Acosta Ledesma',  20, '+5493515550005', 'Av. Colón 1100, Córdoba',             4);

INSERT INTO funcionarios (rut_funcionario, nombres, apellidos, edad, direccion, saludo, id_campus) VALUES
('28345678', 'Carolina', 'Aguilar Ramos',  38, 'Calle Florida 100, Buenos Aires', 'Buena',          1),
('22234567', 'Roberto',  'Jara Molina',    45, 'Av. Cabildo 2000, Buenos Aires',  'Regular',          2),
('30456789', 'Patricia', 'Tapia Rojas',    41, 'Calle Dean Funes 55, Córdoba',    'Buena', 3),
('20987654', 'Luis',     'Cárdenas Peña',  50, 'Av. Oroño 300, Rosario',          'Delicada',          4),
('32567890', 'Marcela',  'Lagos Ibáñez',   35, 'Calle Godoy Cruz 78, Mendoza',    'Excelente',        5),
('35876543', 'Andrés',   'Mena Sepúlveda', 29, 'Av. Belgrano 900, Buenos Aires',  'Regular',          1),
('18555666', 'Ernesto',  'Quiroga Páez',   52, 'Calle Sarmiento 400, Mendoza',    'Delicada',          5);

INSERT INTO bibliotecas (nombre) VALUES
('Biblioteca Central'), ('Biblioteca de Ciencias'), ('Biblioteca de Humanidades');

INSERT INTO autores (nombre, apellido) VALUES
('Gabriel',    'García Márquez'),
('Isabel',     'Allende'),
('Alejandra',  'Pizarnik'),
('Jorge Luis', 'Borges'),
('Roberto',    'Bolaño'),
('Julio',      'Cortázar'),
('Alfonsina',  'Storni'),
('Mario',      'Vargas Llosa'),
('Manuel',     'Mujica Láinez'),
('Leopoldo',   'Marechal');

INSERT INTO tipo (nombre) VALUES
('Novela'), ('Poesía'), ('Ensayo'), ('Cuento');

INSERT INTO editoriales (nombre, pais) VALUES
('Alfaguara',    'España'),
('Planeta',      'España'),
('Sudamericana', 'Argentina'),
('Anagrama',     'España'),
('Emecé',        'Argentina');

INSERT INTO libros (cod_libro, titulo, anio, id_biblioteca, id_tipo, id_autor, id_editorial) VALUES
('LIB-001', 'Cien años de soledad',              1967, 1, 1, 1, 3),
('LIB-002', 'El amor en los tiempos del cólera', 1985, 1, 1, 1, 1),
('LIB-003', 'La casa de los espíritus',          1982, 1, 1, 2, 2),
('LIB-004', 'Eva Luna',                          1987, 2, 1, 2, 2),
('LIB-005', 'Árbol de Diana',                    1962, 3, 2, 3, 5),
('LIB-006', 'Extracción de la piedra de locura', 1968, 3, 2, 3, 5),
('LIB-007', 'Ficciones',                         1944, 1, 4, 4, 3),
('LIB-008', 'El Aleph',                          1949, 2, 4, 4, 3),
('LIB-009', 'Los detectives salvajes',           1998, 1, 1, 5, 4),
('LIB-010', '2666',                              2004, 2, 1, 5, 4),
('LIB-011', 'Rayuela',                           1963, 1, 1, 6, 3),
('LIB-012', 'Bestiario',                         1951, 3, 4, 6, 3),
('LIB-013', 'Languidez',                         1920, 3, 2, 7, 5),
('LIB-014', 'La ciudad y los perros',            1963, 2, 1, 8, 1),
('LIB-015', 'La fiesta del chivo',               2000, 1, 1, 8, 1),
('LIB-016', 'Bomarzo',                           1962, 2, 1, 9, 3),
('LIB-017', 'Adán Buenosayres',                  1948, 3, 1, 10, 5),
('LIB-018', 'El tamaño de mi esperanza',         1926, 3, 3, 4, 5);

INSERT INTO prestamos (rut_est, rut_funcionario, cod_libro, fecha_prestamo, fecha_devolucion) VALUES
('40123456', '28345678', 'LIB-001', '2026-03-02', '2026-03-16'),
('40123456', '28345678', 'LIB-007', '2026-04-10', '2026-04-24'),
('38876543', '22234567', 'LIB-009', '2026-03-05', '2026-03-19'),
('41034567', '30456789', 'LIB-005', '2026-03-12', '2026-03-26'),
('41034567', '30456789', 'LIB-006', '2026-05-04', '2026-05-18'),
('40456789', '28345678', 'LIB-011', '2026-04-01', '2026-04-15'),
('37654321', '20987654', 'LIB-003', '2026-04-08', '2026-04-22'),
('42345678', '20987654', 'LIB-010', '2026-05-11', '2026-05-25'),
('40234567', '30456789', 'LIB-002', '2026-05-15', '2026-05-29'),
('38987654', '32567890', 'LIB-014', '2026-06-01', '2026-06-15'),
('40567890', '32567890', 'LIB-013', '2026-06-03', '2026-06-17'),
('41123456', '22234567', 'LIB-008', '2026-06-10', '2026-06-24'),
('40345678', '35876543', 'LIB-015', '2026-07-01', '2026-07-15'),
('36765432', '35876543', 'LIB-004', '2026-07-06', '2026-07-20'),
('36765432', '28345678', 'LIB-001', '2026-08-03', '2026-08-17'),
('40123456', '22234567', 'LIB-012', '2026-08-10', '2026-08-24'),
('40345678', '35876543', 'LIB-007', '2026-08-20', '2026-09-03'),
('40456789', '28345678', 'LIB-009', '2026-10-05', '2026-10-19'),
('40234567', '30456789', 'LIB-007', '2026-10-12', '2026-10-26'),
-- datos para la consulta que necesita fechas relativas al mes actual
('38876543', '35876543', 'LIB-001',
    (date_trunc('month', CURRENT_DATE) - INTERVAL '1 month' + INTERVAL '3 days')::date,
    (date_trunc('month', CURRENT_DATE) - INTERVAL '1 month' + INTERVAL '17 days')::date),
('41034567', '30456789', 'LIB-001',
    (date_trunc('month', CURRENT_DATE) - INTERVAL '1 month' + INTERVAL '13 days')::date,
    (date_trunc('month', CURRENT_DATE) - INTERVAL '1 month' + INTERVAL '27 days')::date);