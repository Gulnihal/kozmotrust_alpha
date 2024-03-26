const mongoose = require("mongoose");
const { productSchema } = require("./product");

const favoritesSchema = mongoose.Schema({
  products: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const Favorites = mongoose.model("Favorites", favoritesSchema);
module.exports = Favorites;
