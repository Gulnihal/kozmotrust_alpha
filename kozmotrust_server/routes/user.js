const express = require("express");
const User = require("../models/users.model");
const config = require("../config");
const jwt = require("jsonwebtoken");
const middleware = require("../middleware")
const router = express.Router();

router.route("/:username").get(middleware.checkToken, (req, res) => {
    User.findOne(
        { username: req.params.username },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            return res.json({
                data: result,
                username: req.params.username,
            });
        }
    );
});

router.route("/login").post((req, res) => {
    User.findOne(
        { username: req.body.username },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            if (result === null) {
                return res.status(403).json("Username is incorrect!");
            }
            if (result.password === req.body.password){
                let token = jwt.sign(
                    { username: req.body.username },
                    config.key,
                    { expiresIn: "24h" }
                );
                return res.json({
                    token: token,
                    msg: "Success.",
                });
            }
            else {
                return res.status(403).json("Password is incorrect!");
            }
        }
    );
});

router.route("/register").post((req, res) => {
    const user = new User({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email,
    });
    user
        .save()
        .then(() => {
            return res.status(200).json("OK");
        })
        .catch((err) => {
            return res.status(403).json({ msg: err });
        }) 
});

router.route("/update/:username").patch(middleware.checkToken, (req, res) => {
    User.findOneAndUpdatePassword(
        { username: req.params.username },
        { $set: { password: req.body.password } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "Password successfully updated.",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
    User.findOneAndUpdateEmail(
        { username: req.params.username },
        { $set: { email: req.body.email } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "Email successfully updated.",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

router.route("/delete/:username").delete(middleware.checkToken, (req, res) => {
    User.findOneAndDelete(
        { username: req.params.username },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "User deleted.",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

module.exports = router;
