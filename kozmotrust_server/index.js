const express = require("express");
const mongoose = require("mongoose");
const openai = require("openai", ({
    organization: 'org-3rIrZdNEl7oIhol74DSrWlIN',
}));

const dbURL = 'mongodb://localhost:27017/kozmotrust';
module.exports = async () => {
  try {
      await mongoose.connect(process.env.DB_URL || dbURL, {});
      console.log("CONNECTED TO DATABASE SUCCESSFULLY");
  } catch (error) {
      console.error('COULD NOT CONNECT TO DATABASE:', error.message);
  }
};

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB connected!");
});

const port = process.env.PORT || 5000;
const app = express();

const apiKey = process.env.OPENAI_API_KEY || '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';

const client = new openai({ key: apiKey });

// Example of using the completions API for cosmetics information
const prompt = 'Investigate and provide information about the potential effects of the following ingredients in cosmetic products:';

const ingredientsList = [
  'Retinol',
  'Hyaluronic Acid',
  'Parabens',
  'Fragrance',
  // Add more ingredients as needed for testing
];

const ingredientsPrompt = ingredientsList.map((ingredient, index) => `${index + 1}. ${ingredient}`).join('\n');

const fullPrompt = `${prompt}\n${ingredientsPrompt}`;

client.completions.create({
  model: 'davinci-002', // we can choose different models
  prompt: fullPrompt,
  max_tokens: 200,
})
.then(response => {
  console.log(response.choices[0].text);
})
.catch(error => {
  console.error(error);
});

/**
 * GPT base models can understand and generate natural language or code but are not trained with instruction following.
 * babbage-002	Replacement for the GPT-3 ada and babbage base models.	16,384 tokens	Up to Sep 2021
 * davinci-002	Replacement for the GPT-3 curie and davinci base models.	16,384 tokens	Up to Sep 2021
*/

app.route("/").get((req, res) => res.json("Kozmotrust API"));

app.listen(port, () => console.log(`Kozmotrust Server is running on port ${port}!`));
