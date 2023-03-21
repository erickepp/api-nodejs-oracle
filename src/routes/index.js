const queries = require('../database/queries')

const routerApi = (app) => {
    app.get('/cargarTemporal',  async (req, res) => {
        const result = await queries.cargarTemporal();
        res.json(result);
    })
    app.get('/cargarModelo',  async (req, res) => {
        const result = await queries.cargarModelo();
        res.json(result);
    })
}

module.exports = routerApi
