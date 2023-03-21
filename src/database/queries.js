const dbConfig = require('./dbconfig');
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const fs = require('fs');
let conn;

(async () => {
    conn = await dbConfig.connect();
})();

const cargarTemporal = async () => {
    try {
        const model = (await fs.promises.readFile('src/database/sql/model.sql', 'utf8')).split(';');
        model.pop();

        await conn.execute(model.pop());
        await exec('sqlldr erick/12345@xe control=src/database/load/control.ctl');

        return { message: 'Carga a tabla temporal realizada con éxito'};
    } catch (err) {
        console.error(err);
    }
}

const cargarModelo = async () => {
    try {
        const model = (await fs.promises.readFile('src/database/sql/model.sql', 'utf8')).split(';');
        model.splice(-2);
        const inserts = (await fs.promises.readFile('src/database/sql/inserts.sql', 'utf8')).split(';');
        inserts.pop();

        for (let table of model) {
            await conn.execute(table);
        }
        for (let insert of inserts) {
            await conn.execute(insert);
            await conn.commit();
        }

        return { message: 'Modelo cargado con éxito'};
    } catch (err) {
        console.error(err);
    }
}

module.exports = {
    cargarTemporal,
    cargarModelo
}
