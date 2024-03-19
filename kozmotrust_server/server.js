import express from "express";

const app = express();
app.get("/get-listings", (req, res) => {
   res.send({});
});

app.listen(8080);
