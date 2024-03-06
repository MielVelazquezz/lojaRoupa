const express = require('express');
const mysql = require('mysql');

const app = express();

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'lojaRoupa'
});

connection.connect();

app.get('/api/json', (req, res) => {

    const sql = "SELECT * FROM visualizarvendas";

    connection.query(sql, (error, results, fields) => {
        if (error) {
            return res.status(500).json({ error: 'Erro ao executar a consulta.' });
        }

        res.json(results);
    });
});

// http://localhost:3000/api/json → endpoint

const port = 3000;
app.listen(port, () => {
    console.log(`Servidor está rodando em http://localhost:${port}`);
});
