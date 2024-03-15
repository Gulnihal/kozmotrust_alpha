const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
  username: {
    required: true,
    type: String,
    trim: true,
    unique: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
    unique: true,
  },
  password: {
    required: true,
    type: String,
  },
  allergies: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  favorites: [
    {
      product: productSchema,
    },
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
