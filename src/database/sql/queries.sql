SELECT
    hospitales.nombre AS nombre_hospital,
    hospitales.direccion AS direccion_hospital,
    COUNT(*) AS numero_fallecidos
FROM hospitales
INNER JOIN victimas
ON hospitales.id = victimas.hospital_id
WHERE victimas.fecha_muerte IS NOT NULL
    OR victimas.estado_enfermedad = 'Muerte'
GROUP BY hospitales.nombre, hospitales.direccion
ORDER BY numero_fallecidos DESC;

SELECT victimas.nombre, victimas.apellido
FROM detalle_tratamientos
INNER JOIN victimas
ON detalle_tratamientos.victima_id = victimas.id
INNER JOIN tratamientos
ON detalle_tratamientos.tratamiento_id = tratamientos.id
WHERE victimas.estado_enfermedad = 'En cuarentena'
    AND detalle_tratamientos.efectividad_en_victima > 5
    AND tratamientos.descripcion = 'Transfusiones de sangre'
ORDER BY victimas.nombre ASC;

SELECT
    nombre_victima,
    apellido_victima,
    MAX(direccion) AS direccion_victima
FROM (
    SELECT DISTINCT
        victimas.nombre AS nombre_victima,
        victimas.apellido AS apellido_victima,
        victimas.direccion,
        asociados.nombre,
        asociados.apellido
    FROM detalle_asociados
    INNER JOIN victimas
    ON detalle_asociados.victima_id = victimas.id
    INNER JOIN asociados
    ON detalle_asociados.asociado_id = asociados.id
    WHERE victimas.fecha_muerte IS NOT NULL
        OR victimas.estado_enfermedad = 'Muerte'
)
GROUP BY nombre_victima, apellido_victima
HAVING COUNT(*) > 3
ORDER BY nombre_victima ASC;

SELECT victimas.nombre, victimas.apellido
FROM detalle_contactos
INNER JOIN detalle_asociados
ON detalle_contactos.detalle_asociado_id = detalle_asociados.id
INNER JOIN victimas
ON detalle_asociados.victima_id = victimas.id
INNER JOIN contactos
ON detalle_contactos.contacto_id = contactos.id
WHERE victimas.estado_enfermedad = 'Suspendida'
    AND contactos.descripcion = 'Beso'
ORDER BY victimas.nombre ASC;

SELECT
    MAX(victimas.nombre) AS nombre_victima,
    MAX(victimas.apellido) AS apellido_victima,
    COUNT(*) AS total_tratamientos
FROM detalle_tratamientos
INNER JOIN victimas
ON detalle_tratamientos.victima_id = victimas.id
INNER JOIN tratamientos
ON detalle_tratamientos.tratamiento_id = tratamientos.id
WHERE tratamientos.descripcion = 'Oxigeno'
GROUP BY victimas.id, tratamientos.id
ORDER BY total_tratamientos
FETCH FIRST 5 ROWS ONLY;

SELECT victimas.nombre, victimas.apellido, victimas.fecha_muerte
FROM detalle_tratamientos
INNER JOIN victimas
ON detalle_tratamientos.victima_id = victimas.id
INNER JOIN tratamientos
ON detalle_tratamientos.tratamiento_id = tratamientos.id
INNER JOIN detalle_ubicaciones
ON detalle_ubicaciones.victima_id = victimas.id
INNER JOIN ubicaciones
ON detalle_ubicaciones.ubicacion_id = ubicaciones.id
WHERE ubicaciones.direccion = '1987 Delphine Well'
    AND tratamientos.descripcion = 'Manejo de la presion arterial'
ORDER BY victimas.nombre ASC;

SELECT
    MAX(victimas.nombre) AS nombre_victima,
    MAX(victimas.apellido) AS apellio_victima,
    MAX(victimas.direccion) AS direccion_victima
FROM detalle_tratamientos
INNER JOIN victimas
ON detalle_tratamientos.victima_id = victimas.id
GROUP BY victimas.id
HAVING COUNT(*) = 2
ORDER BY nombre_victima ASC;

SELECT *
FROM (
    SELECT
        MAX(EXTRACT(MONTH FROM victimas.fecha_primera_sospecha))
            AS mes_primera_sospecha,
        MAX(victimas.nombre) AS nombre_victima,
        MAX(victimas.apellido) AS apellido_victima,
        COUNT(*) AS total_tratamientos
    FROM detalle_tratamientos
    INNER JOIN victimas
    ON detalle_tratamientos.victima_id = victimas.id
    GROUP BY victimas.id
)
WHERE total_tratamientos IN (
    (SELECT MAX(total_tratamientos) 
    FROM (
        SELECT COUNT(*) AS total_tratamientos
        FROM detalle_tratamientos
        GROUP BY detalle_tratamientos.victima_id
    )),
    (SELECT MIN(total_tratamientos) 
    FROM (
        SELECT COUNT(*) AS total_tratamientos
        FROM detalle_tratamientos
        GROUP BY detalle_tratamientos.victima_id
    ))
)
ORDER BY mes_primera_sospecha DESC;

SELECT
    hospitales.nombre,
    hospitales.direccion,
    COUNT(*)*100 / (SELECT COUNT(*) FROM victimas) AS porcentaje
FROM hospitales
INNER JOIN victimas
ON hospitales.id = victimas.hospital_id
GROUP BY hospitales.nombre, hospitales.direccion
ORDER BY porcentaje DESC;

SELECT
    MAX(hospitales.nombre) AS nombre_hospital,
    MAX(contactos.descripcion) AS contacto_fisico,
    COUNT(*) AS total
FROM hospitales
INNER JOIN victimas
ON hospitales.id = victimas.hospital_id
INNER JOIN detalle_asociados
ON victimas.id = detalle_asociados.victima_id
INNER JOIN detalle_contactos
ON detalle_asociados.id = detalle_contactos.detalle_asociado_id
INNER JOIN contactos
ON detalle_contactos.contacto_id = contactos.id
GROUP BY hospitales.id, contactos.id
ORDER BY total DESC;
