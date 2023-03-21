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
    app.get('/eliminarTemporal',  async (req, res) => {
        const result = await queries.eliminarTemporal();
        res.json(result);
    })
    app.get('/eliminarModelo',  async (req, res) => {
        const result = await queries.eliminarModelo();
        res.json(result);
    })
}

module.exports = routerApi
