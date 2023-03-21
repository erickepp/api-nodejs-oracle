const express = require('express');
const router = express.Router();
const dbConfig = require('../database/dbconfig');
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const fs = require('fs');
let conn;

(async () => {
    conn = await dbConfig.connect();
})();

router.get('/cargarTemporal', async (req, res) => {
    try {
        const model = (await fs.promises.readFile('src/database/sql/model.sql', 'utf8')).split(';');
        model.pop();

        await conn.execute(model.pop());
        await exec('sqlldr erick/12345@xe control=src/database/load/control.ctl');

        res.json({ message: 'Carga a tabla temporal realizada con éxito' });
    } catch (err) {
        console.error(err);
    }
})

router.get('/cargarModelo', async (req, res) => {
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

        res.json({ message: 'Modelo cargado con éxito' });
    } catch (err) {
        console.error(err);
    }
})

router.get('/eliminarTemporal', async (req, res) => {
    try {
        await conn.execute('TRUNCATE TABLE temporal');
        await conn.commit();
        res.json({ message: 'Datos eliminados de tabla temporal' });
    } catch (err) {
        console.error(err);
    }
})

router.get('/eliminarModelo', async (req, res) => {
    try {
        const statements = (await fs.promises.readFile('src/database/sql/delete.sql', 'utf8')).split(';');
        statements.pop();

        for (let statement of statements) {
            await conn.execute(statement);
            await conn.commit();
        }

        res.json({ message: 'Modelo eliminado con éxito' });
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta1', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[0]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta2', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[1]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta3', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[2]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta4', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[3]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta5', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[4]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta6', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[5]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta7', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[6]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta8', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[7]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta9', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[8]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

router.get('/consulta10', async (req, res) => {
    try {
        const query = (await fs.promises.readFile('src/database/sql/queries.sql', 'utf8')).split(';');
        const result = await conn.execute(query[9]);

        const data = {
            columns: result.metaData.map(column => column.name),
            rows: result.rows
        };

        res.json(data);
    } catch (err) {
        console.error(err);
    }
})

module.exports = router;
