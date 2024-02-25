const express = require("express");
const User = require("../models/users.model");

const router = express.Router();

router.route("/register").post((req, res) => {
    const user = new User({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email,
    });
    user
        .save()
        .then(() => {
            res.status(200).json("OK");
        })
        .catch((err) => {
            res.status(403).json({ msg: err });
        })
    res.json("Registered.")
});

module.exports = router;
