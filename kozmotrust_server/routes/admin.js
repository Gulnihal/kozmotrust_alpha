const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, brand, description, ingredients, image, category, combination, dry, normal, oily, sensitive } = req.body;
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

// Update product
adminRouter.patch("/admin/edit-product", admin, async (req, res) => {
  try {
    const { id, name, brand, description, ingredients, image, category, combination, dry, normal, oily, sensitive } = req.body;
    let product = await Product.findById(id);

    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }

    // Update product attributes
    product.name = name;
    product.brand = brand;
    product.description = description;
    product.ingredients = ingredients;
    product.image = image;
    product.category = category;
    product.combination = combination;
    product.dry = dry;
    product.normal = normal;
    product.oily = oily;
    product.sensitive = sensitive;

    // Save the updated product
    await product.save();

    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


// Delete the product
adminRouter.delete("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;
