const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const dbConfig = require("./db/config");
const orderController = require("./controller/order.controller");

const app = express();
app.use(cors());
app.use(express.json());

// connected to database
mongoose
  .connect(dbConfig.url, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("Connected to the database!");
  })
  .catch((err) => {
    console.log("Cannot connect to the database!", err);
    process.exit();
  });

app.get("/", (req, res) => res.json({ message: "Mobile pipelie service." }));

app.get("/orders", orderController.findAll);
app.delete("/orders", orderController.deleteAll);
app.post("/orders", orderController.create);
app.put("/orders/:id", orderController.updateOne);

app.listen(3000, () => {
  console.log("Server running at port 3000");
});
