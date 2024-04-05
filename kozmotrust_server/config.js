require('dotenv').config();

module.exports = {
    mongoDbUrl: process.env.MONGODBURL,
    secretKey: 'Kozmotrust',
    port: 5000,
};
