CREATE PROCEDURE sp_registrar_prestamo(
p_dni_est VARCHAR(12),
p_cod_libro VARCHAR(20),
p_dni_funcionario VARCHAR(12),
p_fecha_prestamo DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM prestamos
        WHERE cod_libro = p_cod_libro
            AND (fecha_devolucion IS NULL OR fecha_devolucion >= CURRENT_DATE)
    ) THEN
        RAISE EXCEPTION 'El libro % ya está prestado y no ha sido devuelto.', p_cod_libro;
    END IF;

    INSERT INTO prestamos (dni_est, dni_funcionario, cod_libro, fecha_prestamo,fecha_devolucion)
    VALUES (p_dni_est, p_dni_funcionario, p_cod_libro, p_fecha_prestamo, p_fecha_prestamo + 7);

    RAISE NOTICE 'Prestamo ragistrado correctamente';
END;
$$;

--prueba: caso exitoso
CALL sp_registrar_prestamo('40123456', 'LIB-018', '28345678', CURRENT_DATE);

--prueba: caso de libro ya prestado, debe dar error
CALL sp_registrar_prestamo('38876543', 'LIB-018', '28345678', CURRENT_DATE);