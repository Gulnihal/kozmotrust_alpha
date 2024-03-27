const mongoose = require("mongoose");
const { productSchema } = require("./product");

const favoritesSchema = mongoose.Schema({
  products: [
    {
      product: productSchema,
    },
  ],
});

const Favorites = mongoose.model("Favorites", favoritesSchema);
module.exports = Favorites;
