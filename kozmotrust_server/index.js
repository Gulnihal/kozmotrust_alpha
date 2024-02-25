const express = require("express");
const mongoose = require("mongoose");
const port = process.env.port || 5000;
const app = express();

mongoose.connect("mongodb://localhost:27017/kozmotrust", { 
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

mongoose.connection.on('connected', () => {
  console.log('Connected to MongoDB');
});

mongoose.connection.on('error', (err) => {
  console.error(`MongoDB connection error: ${err}`);
});

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB connected!");
});

//middleware
app.use(express.json());
const userRoute = require("./routes/user");
app.use("/user", userRoute)

app.route("/").get((req, res) => res.json("Kozmotrust API"));

app.listen(port, () => console.log(`Kozmotrust Server is running on port ${port}!`));
