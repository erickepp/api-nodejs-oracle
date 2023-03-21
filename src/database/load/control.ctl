OPTIONS (SKIP=1)
LOAD DATA
CHARACTERSET UTF8
INFILE 'src/database/load/DB_Excel.csv'
INTO TABLE temporal TRUNCATE
FIELDS TERMINATED BY ';'
TRAILING NULLCOLS (
    nombre_victima,
    apellido_victima,
    direccion_victima,
    fecha_primera_sospecha DATE "DD/MM/YYYY HH24:MI",
    fecha_confirmacion DATE "DD/MM/YYYY HH24:MI",
    fecha_muerte DATE "DD/MM/YYYY HH24:MI",
    estado_victima,
    nombre_asociado,
    apellido_asociado,
    fecha_conocio DATE "DD/MM/YYYY HH24:MI",
    contacto_fisico,
    fecha_inicio_contacto DATE "DD/MM/YYYY HH24:MI",
    fecha_fin_contacto DATE "DD/MM/YYYY HH24:MI",
    nombre_hospital,
    direccion_hospital,
    ubicacion_victima,
    fecha_llegada DATE "DD/MM/YYYY HH24:MI",
    fecha_retiro DATE "DD/MM/YYYY HH24:MI",
    tratamiento,
    efectividad,
    fecha_inicio_tratamiento DATE "DD/MM/YYYY HH24:MI",
    fecha_fin_tratamiento DATE "DD/MM/YYYY HH24:MI",
    efectividad_en_victima
)
