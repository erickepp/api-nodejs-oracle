CREATE TABLE hospitales (
    id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre    VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(100) NOT NULL
);

CREATE TABLE tratamientos (
    id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR2(100) NOT NULL,
    efectividad INTEGER NOT NULL CHECK (efectividad BETWEEN 1 AND 10)
);

CREATE TABLE ubicaciones (
    id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    direccion VARCHAR2(100) NOT NULL
);

CREATE TABLE asociados (
    id       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre   VARCHAR2(50) NOT NULL,
    apellido VARCHAR2(50) NOT NULL
);

CREATE TABLE contactos (
    id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR2(100) NOT NULL
);

CREATE TABLE victimas (
    id                     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre                 VARCHAR2(50) NOT NULL,
    apellido               VARCHAR2(50) NOT NULL,
    direccion              VARCHAR2(100) NOT NULL,
    fecha_primera_sospecha DATE NOT NULL,
    fecha_confirmacion     DATE NOT NULL,
    fecha_muerte           DATE,
    estado_enfermedad      VARCHAR2(50) NOT NULL,
    hospital_id            INTEGER REFERENCES hospitales(id)
);

CREATE TABLE detalle_tratamientos (
    id                       INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_inicio_tratamiento DATE NOT NULL,
    fecha_fin_tratamiento    DATE NOT NULL,
    efectividad_en_victima   INTEGER NOT NULL CHECK (efectividad_en_victima BETWEEN 1 AND 10),
    victima_id               INTEGER REFERENCES victimas(id) NOT NULL,
    tratamiento_id           INTEGER REFERENCES tratamientos(id) NOT NULL
);

CREATE TABLE detalle_ubicaciones (
    id            INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_llegada DATE NOT NULL,
    fecha_retiro  DATE NOT NULL,
    victima_id    INTEGER REFERENCES victimas(id) NOT NULL,
    ubicacion_id  INTEGER REFERENCES ubicaciones(id) NOT NULL
);

CREATE TABLE detalle_asociados (
    id                         INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_conocimiento_victima DATE NOT NULL,
    victima_id                 INTEGER REFERENCES victimas(id) NOT NULL,
    asociado_id                INTEGER REFERENCES asociados(id) NOT NULL
);

CREATE TABLE detalle_contactos (
    id                    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_inicio_contacto DATE NOT NULL,
    fecha_fin_contacto    DATE NOT NULL,
    detalle_asociado_id   INTEGER REFERENCES detalle_asociados(id) NOT NULL,
    contacto_id           INTEGER REFERENCES contactos(id) NOT NULL
);

CREATE TABLE temporal (
    nombre_victima           VARCHAR2(50),
    apellido_victima         VARCHAR2(50),
    direccion_victima        VARCHAR2(100),
    fecha_primera_sospecha   DATE,
    fecha_confirmacion       DATE,
    fecha_muerte             DATE,
    estado_victima           VARCHAR2(50),
    nombre_asociado          VARCHAR2(50),
    apellido_asociado        VARCHAR2(50),
    fecha_conocio            DATE,
    contacto_fisico          VARCHAR2(100),
    fecha_inicio_contacto    DATE,
    fecha_fin_contacto       DATE,
    nombre_hospital          VARCHAR2(100),
    direccion_hospital       VARCHAR2(100),
    ubicacion_victima        VARCHAR2(100),
    fecha_llegada            DATE,
    fecha_retiro             DATE,
    tratamiento              VARCHAR2(100),
    efectividad              INTEGER CHECK (efectividad BETWEEN 1 AND 10),
    fecha_inicio_tratamiento DATE,
    fecha_fin_tratamiento    DATE,
    efectividad_en_victima   INTEGER CHECK (efectividad_en_victima BETWEEN 1 AND 10)
);
