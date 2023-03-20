const oracledb = require('oracledb');

async function connect() {
    let connection;
    
    try {
        connection = await oracledb.getConnection({
            user: 'erick',
            password: '12345',
            connectString: 'localhost/xe'
        });

        console.log('Conexión exitosa a la base de datos Oracle');

        return connection;
    } catch (err) {
        console.error('Error al conectarse a la base de datos Oracle:', err);
        throw err;
    }
}

module.exports = { connect };
