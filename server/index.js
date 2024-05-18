require("dotenv").config();

const express = require('express');
const mongoose = require('mongoose');

const historyRouter = require('./routes/history');

const app = express();
const PORT = process.env.PORT || 3000;
const DB = process.env.DB_CONNECTION_STRING;

app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({limit: '50mb', extended: true }));

app.use(express.json());

app.use(historyRouter);

mongoose.connect(DB)
    .then(() => {
        console.log("connection successful");
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});