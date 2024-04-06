// IMPORTS FROM PACKAGES
const express = require("express");
const logger = require("morgan");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const session = require("express-session");
const mongoose = require("mongoose");
const MongoStore = require("connect-mongo");
const cors = require("cors");
// IMPORTS FROM OTHER FILES
const adminRouter = require("./routes/admin");
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const gptRouter = require("./routes/gpt");
// INIT
const { secretKey, mongoDbUrl, port } = require("./config");
const app = express();

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
app.use(gptRouter);
app.use(cors());

// database connection
mongoose.connect(mongoDbUrl);
const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB connected!");
});
 
// other features
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(
  session({
    secret: secretKey,
    resave: false,
    saveUninitialized: false,
    store: MongoStore.create({
      mongoUrl: mongoDbUrl,
    }),
    cookie: { maxAge: 180 * 60 * 1000 },
  }),
);

app.route("/").get((req, res) => res.json("Kozmotrust Server!"));

app.listen(port, () => console.log(`Kozmotrust Server is running on port ${port}!`));
