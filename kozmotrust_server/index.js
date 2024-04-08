// IMPORTS FROM PACKAGES
const express = require("express");
const logger = require("morgan");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const mongoose = require("mongoose");
const MongoStore = require("connect-mongo");
const cors = require("cors");
require('dotenv').config();

// IMPORTS FROM OTHER FILES
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const gptRouter = require("./routes/gpt");

//OPEN AI
const openai = require("openai");
require('dotenv').config();
const AIapiKey = process.env.AIAPIKEY;
const client = new openai({ apiKey: AIapiKey });

// WEATHER
const axios = require('axios');
const apiKey = process.env.WEATHER_API_KEY;
const city = 'Ankara';
var weatherData;
axios.get(`http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}`)
  .then(response => {
    weatherData = response.data;
  })
  .catch(error => {
    console.log(error);
  });

// INIT
const { secretKey, mongoDbUrl, port } = require("./config");
const app = express();

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
app.use(gptRouter);
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

app.route("/").get((req, res) => res.json("Kozmotrust Server!"));
// TODO this is temporary option it will be fixed for updating weather with time period
var modelWeather;
app.route("/gptweather").get(async (req, res) => res.json({
  "modelAnswer": modelWeather,
  "weatherData": weatherData
}));
app.listen(port, async () => {
  try {
    // Fine tuning with using the completions API for weather condition
    const prompt = "I will provide you with information about a weather status. "+
    "Based on the given information, you will give information about how weather generally effects skin or possible health condisions. "+
    "You can give general summerize with couple of sentences and warn them if a warning neccessary.";

    const fullPrompt = `${prompt}\nWeather: ${JSON.stringify(weatherData)}`;

    var messages = [
    {
        "role": "system",
        "content": "You are an experienced doctor that helps people by suggesting detailed explanation about how weather generally effects skin or possible health condisions. "+
        "You can also provide tips and tricks for avoiding any possible health condition causing by weather status.",
    },
    {
        "role": "system",
        "content": "Your client is going to ask for information about a weather status. "+
        "You can give general summerize with couple of sentences and warn people if a warning neccessary."+
        "If you are done, then you can end the conversation.",
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
        
    return (response.choices[0].message.content);
    };
    modelWeather = await answer(messages);
    console.log(modelWeather);
    return console.log(`Kozmotrust Server is running on port ${port}!`);
    } catch (e) {
      return console.log("Error.");
    }
  });
