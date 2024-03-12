const express = require("express");
const logger = require("morgan");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const mongoose = require("mongoose");
const MongoStore = require('connect-mongo');

const userRoutes = require('./routes/user');

const { mongoDbUrl, port } = require("./config");

mongoose.connect(mongoDbUrl);

const openai = require("openai", ({
    organization: 'org-3rIrZdNEl7oIhol74DSrWlIN',
}));


const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB connected!");
});

const app = express();

app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(
  session({
    secret: 'secret',
    resave: false,
    saveUninitialized: false,
    store: MongoStore.create({
      mongoUrl: mongoDbUrl,
    }),
    cookie: { maxAge: 180 * 60 * 1000 },
  }),
);

// const apiKey = process.env.OPENAI_API_KEY || 'sk-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';

// const client = new openai({ key: apiKey });

// // Example of using the completions API for cosmetics information
// const prompt = 'Investigate and provide information about the potential effects of the following ingredients in cosmetic products:';

// const ingredientsList = [
//   'Retinol',
//   'Hyaluronic Acid',
//   'Parabens',
//   'Fragrance',
//   // Add more ingredients as needed for testing
// ];

// const ingredientsPrompt = ingredientsList.map((ingredient, index) => `${index + 1}. ${ingredient}`).join('\n');

// const fullPrompt = `${prompt}\n${ingredientsPrompt}`;

// client.completions.create({
//   model: 'davinci-002', // we can choose different models
//   prompt: fullPrompt,
//   max_tokens: 200,
// })
// .then(response => {
//   console.log(response.choices[0].text);
// })
// .catch(error => {
//   console.error(error);
// });

/**
 * GPT base models can understand and generate natural language or code but are not trained with instruction following.
 * babbage-002	Replacement for the GPT-3 ada and babbage base models.	16,384 tokens	Up to Sep 2021
 * davinci-002	Replacement for the GPT-3 curie and davinci base models.	16,384 tokens	Up to Sep 2021
*/
app.use('/user', userRoutes);

app.route("/").get((req, res) => res.json("Kozmotrust Server!"));

app.listen(port, () => console.log(`Kozmotrust Server is running on port ${port}!`));
