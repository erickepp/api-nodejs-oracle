const queries = require('../database/queries')

const routerApi = (app) => {
    app.get('/cargarTemporal',  async (req, res) => {
        const result = await queries.cargarTemporal();
        res.json(result);
    })
}

module.exports = routerApi
