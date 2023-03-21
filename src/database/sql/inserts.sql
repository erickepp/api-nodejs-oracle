INSERT INTO hospitales (nombre, direccion)
SELECT DISTINCT nombre_hospital, direccion_hospital
FROM temporal
WHERE nombre_hospital IS NOT NULL;

INSERT INTO tratamientos (descripcion, efectividad)
SELECT DISTINCT tratamiento, efectividad
FROM temporal
WHERE tratamiento IS NOT NULL;

INSERT INTO ubicaciones (direccion)
SELECT DISTINCT ubicacion_victima
FROM temporal
WHERE ubicacion_victima IS NOT NULL;

INSERT INTO asociados (nombre, apellido)
SELECT DISTINCT nombre_asociado, apellido_asociado
FROM temporal
WHERE nombre_asociado IS NOT NULL;

INSERT INTO contactos (descripcion)
SELECT DISTINCT contacto_fisico
FROM temporal
WHERE contacto_fisico IS NOT NULL;

INSERT INTO victimas (
    nombre,
    apellido,
    direccion,
    fecha_primera_sospecha,
    fecha_confirmacion,
    fecha_muerte,
    estado_enfermedad,
    hospital_id
)
SELECT DISTINCT
    temporal.nombre_victima,
    temporal.apellido_victima,
    temporal.direccion_victima,
    temporal.fecha_primera_sospecha,
    temporal.fecha_confirmacion,
    temporal.fecha_muerte,
    temporal.estado_victima,
    hospitales.id
FROM temporal
LEFT JOIN hospitales
ON temporal.nombre_hospital = hospitales.nombre
    AND temporal.direccion_hospital = hospitales.direccion
WHERE temporal.nombre_victima IS NOT NULL;

INSERT INTO detalle_tratamientos (
    fecha_inicio_tratamiento,
    fecha_fin_tratamiento,
    efectividad_en_victima,
    victima_id,
    tratamiento_id
)
SELECT DISTINCT
    temporal.fecha_inicio_tratamiento,
    temporal.fecha_fin_tratamiento,
    temporal.efectividad_en_victima,
    victimas.id,
    tratamientos.id
FROM temporal
INNER JOIN victimas
ON temporal.nombre_victima = victimas.nombre
    AND temporal.apellido_victima = victimas.apellido
INNER JOIN tratamientos
ON temporal.tratamiento = tratamientos.descripcion;

INSERT INTO detalle_ubicaciones (
    fecha_llegada,
    fecha_retiro,
    victima_id,
    ubicacion_id
)
SELECT DISTINCT
    temporal.fecha_llegada,
    temporal.fecha_retiro,
    victimas.id,
    ubicaciones.id
FROM temporal
INNER JOIN victimas
ON temporal.nombre_victima = victimas.nombre
    AND temporal.apellido_victima = victimas.apellido
INNER JOIN ubicaciones
ON temporal.ubicacion_victima = ubicaciones.direccion;

INSERT INTO detalle_asociados (
    fecha_conocimiento_victima,
    victima_id,
    asociado_id
)
SELECT DISTINCT
    temporal.fecha_conocio,
    victimas.id,
    asociados.id
FROM temporal
INNER JOIN victimas
ON temporal.nombre_victima = victimas.nombre
    AND temporal.apellido_victima = victimas.apellido
INNER JOIN asociados
ON temporal.nombre_asociado = asociados.nombre
    AND temporal.apellido_asociado = asociados.apellido;

INSERT INTO detalle_contactos (
    fecha_inicio_contacto,
    fecha_fin_contacto,
    detalle_asociado_id,
    contacto_id
)
SELECT DISTINCT
    temporal.fecha_inicio_contacto,
    temporal.fecha_fin_contacto,
    detalle_asociados.id,
    contactos.id
FROM temporal
INNER JOIN victimas
ON temporal.nombre_victima = victimas.nombre
    AND temporal.apellido_victima = victimas.apellido
INNER JOIN asociados
ON temporal.nombre_asociado = asociados.nombre
    AND temporal.apellido_asociado = asociados.apellido
INNER JOIN detalle_asociados
ON victimas.id = detalle_asociados.victima_id
    AND asociados.id = detalle_asociados.asociado_id
    AND temporal.fecha_conocio = detalle_asociados.fecha_conocimiento_victima
INNER JOIN contactos
ON temporal.contacto_fisico = contactos.descripcion;
