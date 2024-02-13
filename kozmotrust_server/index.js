const express = require("express");
const mongoose = require("mongoose");

mongoose.connect("mongodb://localhost:27017/myapp", { useNewUrlParser: true });

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDBb connected!");
});

const port = process.env.port || 5000;
const app = express();

app.route("/").get((req, res) => res.json("Kozmotrust API"));

app.listen(5000, () => console.log(`Kozmotrust Server is running on port ${port}!`));
