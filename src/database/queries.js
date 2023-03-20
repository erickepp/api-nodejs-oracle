const dbConfig = require('./dbconfig');
const util = require('util');
const exec = util.promisify(require('child_process').exec);
let conn;

(async () => {
    conn = await dbConfig.connect();
})();

const cargarTemporal = async () => {
    try {
        await conn.execute(`
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
            )
        `);
        
        await exec('sqlldr erick/12345@xe control=src/database/carga/control.ctl');
        return { message: 'Carga a tabla temporal realizada con éxito'};
    } catch (err) {
        console.error(err);
    }
}

module.exports = {
    cargarTemporal
}
