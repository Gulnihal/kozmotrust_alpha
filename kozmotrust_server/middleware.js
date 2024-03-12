const config = require("./config");
const jwt = require("jsonwebtoken");

const checkToken = (req, res, next) => {
    let token = req.headers["Authorization."];
    console.log(token);
    token = token.slice(7, token.length);
    if (token) {
        jwt.verify(token, config.key, (err, decoded) => {
            if (err) {
                return res.json({
                    status: false,
                    msg: "Token is invalid."
                });
            }
            else {
                req.decoded = decoded;
                next();
            }
        });
    }
    else {
        return res.json({
            status: false,
            msg: "Token is not provided."
        });
    }
    next();
};

module.exports = {
    checkToken: checkToken,
};
