const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");

userRouter.post("/api/add-to-favorites", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.favorites.length == 0) {
      user.favorites.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.favorites.length; i++) {
        if (user.favorites[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        let producttt = user.favorites.find((productt) =>
          productt.product._id.equals(product._id)
        );
        producttt.quantity += 1;
      } else {
        user.favorites.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.delete("/api/remove-from-favorites/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.favorites.length; i++) {
      if (user.favorites[i].product._id.equals(product._id)) {
        if (user.favorites[i].quantity == 1) {
          user.favorites.splice(i, 1);
        } else {
          user.favorites[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// save user allergies
userRouter.post("/api/save-user-allergies", auth, async (req, res) => {
  try {
    const { allergies } = req.body;
    let user = await User.findById(req.user);
    user.allergies = allergies;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
