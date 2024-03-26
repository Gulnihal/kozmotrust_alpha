const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");
const { secretKey } = require("../config");
const authRouter = express.Router();


// SIGN UP
authRouter.post("/signup", async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const existingUsername = await User.findOne({ username });
    if (existingUsername) {
      return res
        .status(400)
        .json({ msg: "User with same username already exists!" });
    }

    const existingUserEmail = await User.findOne({ email });
    if (existingUserEmail) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      username,
    });
    user = await user.save();
    return res.json(user);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Sign In Route
authRouter.post("/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "E-mail or password is incorrect!" });
    }
    // messages changed for security.
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "E-mail or password is incorrect!" });
    }
    const token = jwt.sign(
      { id: user._id },
      secretKey,
      {
        algorithm: 'HS256',
        allowInsecureKeySizes: true,
        expiresIn: 86400, // 24 hours
      }
    );
    jwt.token = token;
    return res.status(200).json({ accessToken: token, ...user._doc });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Update password
authRouter.patch("/api/update", async (req, res) => {
  try {
    const { password, newPassword } = req.body;
    const token = jwt.token;
    const verified = jwt.verify(token, secretKey);
    var user = await User.findById(verified.id);
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }
    const newHashedPassword = await bcryptjs.hash(newPassword, 8);
    user.password = newHashedPassword;
    user = await user.save();
    return res.json(user);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// Deleting user
authRouter.delete("/api/delete", async (req, res) => {
  try {
    const { password } = req.body;
    const token = jwt.token;
    const verified = jwt.verify(token, secretKey);
    const user = await User.findById(verified.id);
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password." });
    }
    await User.findByIdAndDelete(verified.id);
    return res.json({ msg: "User deleted." });
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// token validation
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = jwt.token;
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, secretKey);
    if (!verified) {
      return res.json(false);
    }

    const user = await User.findById(verified.id);
    if (!user) {
      return res.json(false);
    }
    return res.json(true);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

// get user data
authRouter.get("/api/:user", auth, async (req, res) => {
  const user = await User.findById(req.user);
  return res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
