const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const dbConfig = require("./db/config");
const orderController = require("./controller/order.controller");
const problemController = require("./controller/problem.controller");
const mocksController = require("./controller/mocks.controller");

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

app.post("/orders", orderController.findAll);
app.delete("/orders", orderController.deleteAll);
app.post("/orders/new", orderController.create);
app.put("/orders/:id", orderController.updateOne);

app.post("/problems/new", problemController.create);

app.post("/mocks", mocksController.create);
app.delete("/mocks", mocksController.deleteAll);

app.listen(3000, () => {
  console.log("Server running at port 3000");
});

problemController.initConsumer();
