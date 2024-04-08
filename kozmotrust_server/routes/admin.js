const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, brand, description, ingredients, image, category, combination, dry, normal, oily, sensitive, ratings } = req.body;
    let product = new Product({
      description,
      brand,
      name,
      image,
      ingredients,
      category,
      combination,
      dry,
      normal,
      oily,
      sensitive,
      ratings
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
