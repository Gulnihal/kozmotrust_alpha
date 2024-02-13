const express = require("express");
const app = express();

const Port = process.env.port || 5000;

app.route("/").get((req, res) => res.json("Kozmotrust API"));

app.listen(5000, () => console.log(`Kozmotrust Server is running on port ${Port}!`));
