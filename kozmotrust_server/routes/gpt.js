const express = require("express");
const gptRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const openai = require("openai");

require('dotenv').config();
const AIapiKey = process.env.AIAPIKEY;
const client = new openai({ apiKey: AIapiKey });

gptRouter.post("/api/gptexamine", auth, async (req, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);
      const healthinfo = user.healthinfo;

      // Check if the user exists
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

    // Fine tuning with using the completions API for cosmetics information
    const prompt = "I will provide you with information about a person and a product. "+
    "Based on the given information, we will try to understand the content of the product and its purpose. "+
    "Additionally, we will assess whether this product is suitable for this person based on the information provided by them. "+
    "We must only tell how this product may affect the person positively or negatively to the user. "+
    "We must also do that in language which is the language of \"User Information\" part. If \"User Information\" part is empty, we can give general info in English. "+
    "Your response limited by 3 paragraphs, therefore you should summerize you work but don't lose important details.";

    const fullPrompt = `${prompt}\nUser Info: ${healthinfo}\nProduct: ${JSON.stringify(product)}`;

    var messages = [
    {
        "role": "system",
        "content": "You are an experienced doctor and chemist that helps people by suggesting detailed explanation for cosmetic product, general health effect(skin healt specifically). "+
        "You can also provide tips and tricks for usage details of these products. "+
        "You always try to be as clear as possible and provide the best possible explanation for the user's general information they gave. "+
        "You know a lot about different area of science and you are expert on pharmacy and chemistry. "+
        "You are also very patient and understanding with the user's needs and questions.",
    },
    {
        "role": "system",
        "content": "Your client is going to ask for information about a specific product. "+
        "If you do not recognize the product, you should try to generate an detailed explanation with examining ingredients for it. "+
        "If you know the product, you must answer directly with a detailed explanion like ,effects of each ingredient and if it is suitable for user and etc., for it. "+
        "If it is same product you can give exactly the same answer which you have give before."+
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
    const modelAnswer = await answer(messages);
    return res.json({"modelAnswer": modelAnswer});
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }
);

gptRouter.post("/api/gptweather", auth, async (req, res) => {
  try {
    const { weather } = req.body;

    // Fine tuning with using the completions API for weather condition
    const prompt = "I will provide you with information about a weather status. "+
    "Based on the given information, you will give information about how weather generally effects skin or possible health condisions. "+
    "You can give general summerize with couple of sentences and warn them if a warning neccessary.";

    const fullPrompt = `${prompt}\nWeather: ${JSON.stringify(weather)}`;

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
        "If it is same weather status you can give exactly the same answer which you have give before."+
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
    const modelAnswer = await answer(messages);
    console.log(modelAnswer);
    return res.json({"modelAnswer": modelAnswer});
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }
);

gptRouter.post("/api/gptsuggestions", auth, async (req, res) => {
  try {
    const { extractedProduct } = req.body;

    // Fine tuning with using the completions API for extracted text from an image
    const prompt = "I will provide you with an extracted text from a cosmetic product image via google_mlkit_text_recognition tool for flutter. "+
    "Based on the given text and that text could have some typos, you should correct them if it is possşble for you."+
    "You will give specific information about that cosmetic product. "+
    "You can give general summerize with couple of sentences and give other similar examples of products if you have knowledge about it.";

    const fullPrompt = `${prompt}\nExtracted Product: ${JSON.stringify(extractedProduct)}`;

    var messages = [
    {
        "role": "system",
        "content": "You are an experienced cosmetic shop assistant that helps people by suggesting detailed explanation about cosmetic products. "+
        "You can also provide tips and tricks for the product which your customer seeking for."+
        "Yo can also give other examples of similar products of the given product.",
    },
    {
        "role": "system",
        "content": "Your client is going to ask for information about a product which is searched. "+
        "You can give general summerize with couple of sentences and give other examples of similar products of the given product."+
        "If it is same product you can give exactly the same answer which you have give before. You don't have to ask text if there is no extracted text."+
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
    const modelAnswer = await answer(messages);
    console.log(modelAnswer);
    return res.json({"modelAnswer": modelAnswer});
    } catch (e) {
      return res.status(500).json({ error: e.message });
    }
  }
);

  module.exports = gptRouter;
