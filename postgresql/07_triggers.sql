-- primer trigger
CREATE TABLE AUDITORIA_PRESTAMOS(
    id_auditoria SERIAL PRIMARY KEY,
    dni_est VARCHAR(12) NOT NULL,
    cod_libro VARCHAR(12) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT NOW(),
    accion VARCHAR(50) NOT NULL
);

CREATE OR REPLACE FUNCTION fn_auditar_prestamos()
RETURNS TRIGGER AS $$
BEGIN   
    INSERT INTO AUDITORIA_PRESTAMOS (dni_est, cod_libro, fecha_registro, accion)
    VALUES (NEW.dni_est, NEW.cod_libro, NOW(), 'NUEVO PRESTAMO');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_AUDITAR_PRESTAMOS
AFTER INSERT ON prestamos
FOR EACH ROW
EXECUTE FUNCTION fn_auditar_prestamos();

--para probar el primer trigger
INSERT INTO prestamos (dni_est, dni_funcionario, cod_libro, fecha_prestamo, fecha_devolucion)
VALUES ('40123456', '28345678', 'LIB-001', CURRENT_DATE, CURRENT_DATE + 14);

SELECT * FROM auditoria_prestamos;


-- segundo trigger
CREATE OR REPLACE FUNCTION fn_validar_edad_estudiante()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.edad < 17 THEN
        RAISE EXCEPTION 'Error: El estudiante debe tener al menos 17 años para registrarse'
            USING ERRCODE = '45000';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER TR_VALIDAR_EDAD_ESTUDIANTE
BEFORE INSERT OR UPDATE ON estudiantes
FOR EACH ROW
EXECUTE FUNCTION fn_validar_edad_estudiante();

-- para probar el segundo trigger
INSERT INTO estudiantes (dni_est, nombres, apellidos, edad, telefono, direccion, id_carrera)
VALUES ('43000111', 'Prueba', 'Menor', 15, '+5491100000000', 'Calle Falsa 123', 1);