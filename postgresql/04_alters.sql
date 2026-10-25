--me equivoqué en el nombre de la columna, la renombro
ALTER TABLE funcionarios RENAME COLUMN saludo TO salud;

--renames
ALTER TABLE estudiantes RENAME COLUMN rut_est TO dni_est;
ALTER TABLE funcionarios RENAME COLUMN rut_funcionario TO dni_funcionario;
ALTER TABLE prestamos RENAME COLUMN rut_est TO dni_est;
ALTER TABLE prestamos RENAME COLUMN rut_funcionario TO dni_funcionario;

--agrego atributos
ALTER TABLE estudiantes ADD COLUMN email VARCHAR(100);
ALTER TABLE funcionarios ADD COLUMN email VARCHAR(100);
ALTER TABLE libros ADD COLUMN isbn VARCHAR(20);
ALTER TABLE prestamos ADD COLUMN estado VARCHAR (20) NOT NULL DEFAULT 'activo';

--actualizo los atributos agregados con valores de ejemplo
UPDATE estudiantes e SET email = v.email
FROM (VALUES
    ('40123456', 'camila.rojas@universidad.edu.ar'),
    ('38876543', 'matias.gonzalez@universidad.edu.ar'),
    ('41034567', 'valentina.munoz@universidad.edu.ar'),
    ('40456789', 'sebastian.soto@universidad.edu.ar'),
    ('37654321', 'florencia.vargas@universidad.edu.ar'),
    ('42345678', 'benjamin.silva@universidad.edu.ar'),
    ('40234567', 'julieta.fuentes@universidad.edu.ar'),
    ('38987654', 'diego.castillo@universidad.edu.ar'),
    ('40567890', 'agustina.herrera@universidad.edu.ar'),
    ('41123456', 'tomas.ortiz@universidad.edu.ar'),
    ('40345678', 'catalina.nunez@universidad.edu.ar'),
    ('36765432', 'nicolas.pizarro@universidad.edu.ar')
) AS v(dni, email)
WHERE e.dni_est = v.dni;

UPDATE funcionarios f SET email = v.email
FROM (VALUES
    ('28345678', 'carolina.aguilar@biblioteca.edu.ar'),
    ('22234567', 'roberto.jara@biblioteca.edu.ar'),
    ('30456789', 'patricia.tapia@biblioteca.edu.ar'),
    ('20987654', 'luis.cardenas@biblioteca.edu.ar'),
    ('32567890', 'marcela.lagos@biblioteca.edu.ar'),
    ('35876543', 'andres.mena@biblioteca.edu.ar')
) AS v(dni, email)
WHERE f.dni_funcionario = v.dni;

UPDATE libros l SET isbn = v.isbn
FROM (VALUES
    ('LIB-001', '978-950-07-0001-1'),
    ('LIB-002', '978-950-07-0002-2'),
    ('LIB-003', '978-950-07-0003-3'),
    ('LIB-004', '978-950-07-0004-4'),
    ('LIB-005', '978-950-07-0005-5'),
    ('LIB-006', '978-950-07-0006-6'),
    ('LIB-007', '978-950-07-0007-7'),
    ('LIB-008', '978-950-07-0008-8'),
    ('LIB-009', '978-950-07-0009-9'),
    ('LIB-010', '978-950-07-0010-0'),
    ('LIB-011', '978-950-07-0011-1'),
    ('LIB-012', '978-950-07-0012-2'),
    ('LIB-013', '978-950-07-0013-3'),
    ('LIB-014', '978-950-07-0014-4'),
    ('LIB-015', '978-950-07-0015-5')
) AS v(cod, isbn)
WHERE l.cod_libro = v.cod;

-- todos los prestamos vencidos se marcan como devueltos
UPDATE prestamos SET estado = 'devuelto' WHERE fecha_devolucion < CURRENT_DATE;