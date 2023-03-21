# API Node.js con Oracle

Este es un proyecto Node.js que incluye una API para acceder a una base de datos Oracle. El proyecto carga un modelo de datos y algunos datos de prueba en la base de datos. Luego, ofrece consultas predefinidas a la base de datos para su uso en aplicaciones externas.

## Uso

Para comenzar a usar el proyecto, clona este repositorio de GitHub y ejecuta los siguientes comandos:

    npm install
    npm start

Estos comandos instalan las dependencias del proyecto y lo ejecutan. La API se ejecutará en `http://localhost:3000`.

## Configuración

El proyecto requiere que se proporcione una conexión a una base de datos Oracle. Para configurar la conexión, copia el archivo `config.example.json` a `config.json` y edita el archivo para incluir tus credenciales y detalles de la base de datos.

    {
	    "user": "TU_USUARIO",
	    "password": "TU_CONTRASEÑA",
	    "connectString": "TU_CONEXIÓN_STRING"
	}

## API

El proyecto ofrece las siguientes rutas para acceder a la base de datos:

-   `GET /cargarTemporal`: Carga datos de prueba en una tabla temporal de la base de datos.
-   `GET /cargarModelo`: Carga el modelo de datos y los datos de prueba en la base de datos.
-   `GET /eliminarTemporal`: Elimina los datos de la tabla temporal de la base de datos.
-   `GET /eliminarModelo`: Elimina todo el modelo de datos de la base de datos.
-   `GET /consulta1`: Ofrece la consulta 1 predefinida en el archivo `queries.sql`.
-   `GET /consulta2`: Ofrece la consulta 2 predefinida en el archivo `queries.sql`.
-   `GET /consulta3`: Ofrece la consulta 3 predefinida en el archivo `queries.sql`.
-   `GET /consulta4`: Ofrece la consulta 4 predefinida en el archivo `queries.sql`.
-   `GET /consulta5`: Ofrece la consulta 5 predefinida en el archivo `queries.sql`.
-   `GET /consulta6`: Ofrece la consulta 6 predefinida en el archivo `queries.sql`.

## Base de datos

El proyecto utiliza una base de datos Oracle. Para utilizar el proyecto, debes tener una instancia de Oracle instalada y configurada. La base de datos debe tener un usuario con privilegios de lectura y escritura en la base de datos utilizada por el proyecto.

## Dependencias

El proyecto utiliza las siguientes dependencias de Node.js:

-   `express`: Framework web para Node.js.
-   `oracledb`: Conector de base de datos Oracle para Node.js.
-   `util`: Biblioteca de utilidades para Node.js.
-   `child_process`: Módulo para ejecutar comandos del sistema operativo.
-   `fs`: Módulo para leer archivos del sistema de archivos.

## Contribuciones

Las contribuciones son bienvenidas en este proyecto. Si deseas contribuir, realiza un fork del repositorio y envía un pull request. Por favor, asegúrate de probar tus cambios antes de enviarlos.

## Licencia

Este proyecto está disponible bajo la licencia MIT.