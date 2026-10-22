CREATE DATABASE gestion_bibliotecas;

CREATE TABLE ciudades (
    id_ciudad SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE campus (
    id_campus SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_ciudad INT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES ciudades(id_ciudad)
);

CREATE TABLE carreras (
    id_carrera SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_campus INT NOT NULL,
    FOREIGN KEY (id_campus) REFERENCES campus(id_campus)
);

CREATE TABLE estudiantes (
    rut_est VARCHAR(12) PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    id_carrera INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);

CREATE TABLE funcionarios (
    rut_funcionario VARCHAR(12) PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    saludo VARCHAR(50) NOT NULL,
    id_campus INT NOT NULL,
    FOREIGN KEY (id_campus) REFERENCES campus(id_campus)
);

CREATE TABLE bibliotecas (
    id_biblioteca SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE autores (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL
);

CREATE TABLE tipo (
    id_tipo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE editoriales (
    id_editorial SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

CREATE TABLE libros (
    cod_libro VARCHAR(20) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    anio INT NOT NULL,
    id_biblioteca INT NOT NULL,
    id_tipo INT NOT NULL,
    id_autor INT NOT NULL,
    id_editorial INT NOT NULL,
    FOREIGN KEY (id_biblioteca) REFERENCES bibliotecas(id_biblioteca),
    FOREIGN KEY (id_tipo) REFERENCES tipo(id_tipo),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
);

CREATE TABLE prestamos (
    id_prestamo SERIAL PRIMARY KEY,
    rut_est VARCHAR(12) NOT NULL REFERENCES estudiantes(rut_est),
    rut_funcionario VARCHAR(12) NOT NULL REFERENCES funcionarios(rut_funcionario),
    cod_libro VARCHAR(20) NOT NULL REFERENCES libros(cod_libro),
    fecha_prestamo DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_devolucion DATE,
    CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_prestamo)
);