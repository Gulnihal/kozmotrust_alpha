const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const User = require("../models/user");
const { Product } = require("../models/product");

productRouter.get("/api/products/", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// create a get request to search products by name or brand
// /api/products/search/:query
productRouter.get("/api/products/search/:query", auth, async (req, res) => {
  try {
    const query = req.params.query;
    const products = await Product.find({
      $or: [
        { name: { $regex: query, $options: "i" } },
        { brand: { $regex: query, $options: "i" } }
      ]
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/user/favorites/search/:query", auth, async (req, res) => {
  try {
    const query = req.params.query.toLowerCase(); // Convert query to lowercase
    const user = await User.findById(req.user).populate('favorites'); // Populate the favorites field
    // Filter favorite products that match the search query
    const favoriteProducts = user.favorites.map(favorite => {
      return favorite.product;
    }).filter(product => {
      return (typeof product.name === 'string' && product.name.toLowerCase().includes(query)) || 
       (typeof product.brand === 'string' && product.brand.toLowerCase().includes(query));
    });
    res.json(favoriteProducts);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


// create a post request route to rate the product.
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: req.user,
      rating,
    };

    product.ratings.push(ratingSchema);
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
