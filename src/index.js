const express = require('express')
const queries = require('./routes/queries')
const app = express()
const PORT = process.env.PORT || 3000

app.use(express.json())
app.use(queries)

app.listen(PORT, () => {
    console.log(`Server on port ${PORT}`)
})
