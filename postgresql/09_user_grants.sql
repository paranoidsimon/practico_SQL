-- 1
CREATE USER bibliotecario_user WITH PASSWORD 'contrasena_segura';

GRANT CONNECT ON DATABASE gestion_biblioteca TO bibliotecario_user;
GRANT USAGE ON SCHEMA public TO bibliotecario_user;

-- 2
GRANT SELECT ON libros, autores, editoriales TO bibliotecario_user;

-- 3
GRANT SELECT, INSERT, UPDATE, DELETE ON prestamos TO bibliotecario_user;
-- id_prestamo es SERIAL, y para generarlo se necesita acceso a su secuencia
GRANT USAGE ON SEQUENCE prestamos_id_prestamo_seq TO bibliotecario_user;

-- El trigger TR_AUDITAR_PRESTAMO inserta en auditoria_prestamos con los permisos
-- de quien hace el INSERT; sin esto, el préstamo falla
GRANT INSERT ON auditoria_prestamos TO bibliotecario_user;
GRANT USAGE ON SEQUENCE auditoria_prestamos_id_auditoria_seq TO bibliotecario_user;

-- 4
CREATE USER admin_user WITH PASSWORD 'admin_contrasena_segura';

GRANT ALL PRIVILEGES ON DATABASE gestion_biblioteca TO admin_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO admin_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin_user;
-- las anteriores solo sirven para las tablas ya existentes, para las que se creen en el futuro uso lo siguiente
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO admin_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO admin_user;


-- 5
REVOKE DELETE ON prestamos FROM bibliotecario_user;

