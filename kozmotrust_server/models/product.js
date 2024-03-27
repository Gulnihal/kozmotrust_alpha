const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const productSchema = mongoose.Schema({
  description: {
    type: String,
    required: true,
  },
  brand: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  image: {
      type: String,
  },
  ingredients: {
    type: String,
    required: true,
  },
  category: {
    type: String,
  },
  combination: {
    type: Boolean,
    required: true,
  },
  dry: {
    type: Boolean,
    required: true,
  },
  normal: {
    type: Boolean,
    required: true,
  },
  oily: {
    type: Boolean,
    required: true,
  },
  sensitive: {
    type: Boolean,
    required: true,
  },
  ratings: [ratingSchema],
});

const Product = mongoose.model("Product", productSchema);
module.exports = { Product, productSchema };
