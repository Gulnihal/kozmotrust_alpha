// IMPORTS FROM PACKAGES
const express = require("express");
const logger = require("morgan");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const mongoose = require("mongoose");
const MongoStore = require("connect-mongo");
const cors = require("cors");
// IMPORTS FROM OTHER FILES
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
// INIT
require('dotenv').config();
const { secretKey, mongoDbUrl, port } = require("./config");
const app = express();
const openai = require("openai");

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
app.use(cors());

// database connection
mongoose.connect(mongoDbUrl);
const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB connected!");
});
 
// other features
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(
  session({
    secret: secretKey,
    resave: false,
    saveUninitialized: false,
    store: MongoStore.create({
      mongoUrl: mongoDbUrl,
    }),
    cookie: { maxAge: 180 * 60 * 1000 },
  }),
);
const AIapiKey = process.env.AIAPIKEY;
const client = new openai({ apiKey: AIapiKey });

// Example of using the completions API for cosmetics information
const prompt = "I will provide you with information about a person and a product. Based on the given information, we will try to understand the content of the product and its purpose. Additionally, we will assess whether this product is suitable for this person based on the information provided by them. We must only tell how this product may affect the person positively or negatively to the user,. We must also do that in language which is the language of \"User Information\" part.";

const product = {
  "description": "Moisturizer",
  "brand": "LA MER",
  "name": "Crème de la Mer",
  "images": [],
  "ingredients": "Algae (Seaweed) Extract, Mineral Oil, Petrolatum, Glycerin, Isohexadecane, Microcrystalline Wax, Lanolin Alcohol, Citrus Aurantifolia (Lime) Extract, Sesamum Indicum (Sesame) Seed Oil, Eucalyptus Globulus (Eucalyptus) Leaf Oil, Sesamum Indicum (Sesame) Seed Powder, Medicago Sativa (Alfalfa) Seed Powder, Helianthus Annuus (Sunflower) Seedcake, Prunus Amygdalus Dulcis (Sweet Almond) Seed Meal, Sodium Gluconate, Copper Gluconate, Calcium Gluconate, Magnesium Gluconate, Zinc Gluconate, Magnesium Sulfate, Paraffin, Tocopheryl Succinate, Niacin, Water, Beta-Carotene, Decyl Oleate, Aluminum Distearate, Octyldodecanol, Citric Acid, Cyanocobalamin, Magnesium Stearate, Panthenol, Limonene, Geraniol, Linalool, Hydroxycitronellal, Citronellol, Benzyl Salicylate, Citral, Sodium Benzoate, Alcohol Denat., Fragrance.",
  "combination": true,
  "dry": true,
  "normal": true,
  "oily": true,
  "sensitive": true,
  "ratings": [],
  "_id": "66034020c0be49a08e7edb94"
};

const healthinfo = "44 yaşındayım. 2 çocuğum var. köpeklere alrjim var ama evde beslediğimi için alerji ilacı alıyorum. karma yağlı cildim var 156 boyunda 57 kiloyum.";

const fullPrompt = `${prompt}\nUser Info: ${healthinfo}\nProduct: ${JSON.stringify(product)}`;

var messages = [
  {
    "role": "system",
    "content": "You are an experienced doctor and chemist that helps people by suggesting detailed explanation for cosmetic product, general health effect(skin healt specifically). You can also provide tips and tricks for usage details of these products. You always try to be as clear as possible and provide the best possible explanation for the user's general information they gave. You know a lot about different area of science and you are expert on pharmacy and chemistry. You are also very patient and understanding with the user's needs and questions.",
  },
  {
    "role": "system",
    "content": "Your client is going to ask for information about a specific product. If you do not recognize the product, you should try to generate an detailed explanation with examining ingredients for it. If you know the product, you must answer directly with a detailed explanion like ,effects of each ingredient and if it is suitable for user and etc., for it. If you are done, then you can end the conversation.",
  },
  {
    "role": "user",
    "content": fullPrompt
  },
];

const answer = async (messages) => {
  const response = await client.chat.completions
  .create({
    model: "gpt-4-0125-preview",
    messages: messages,
    temperature: 1.00,
    max_tokens: 4096,
    top_p: 1,
    frequency_penalty: 0,
    presence_penalty: 0,
    });
    
  console.log(response.choices[0]);
};

// answer(messages);

app.route("/").get((req, res) => res.json("Kozmotrust Server!"));

app.listen(port, () => console.log(`Kozmotrust Server is running on port ${port}!`));
