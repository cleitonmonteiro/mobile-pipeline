const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const dbConfig = require("./db/config");
const kafkaHelper = require("./helper/kafka");

const mobileLocationUpdateController = require("./controller/mobileLocationUpdate.controller");
const mocksController = require("./controller/mocks.controller");
const authController = require("./controller/auth.controller");
const fcmController = require("./controller/fcm.controller");
const mobileController = require("./controller/mobile.controller");

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

app.post("/mobileLocationUpdate", mobileLocationUpdateController.create);

app.post("/mocks", mocksController.create);
app.delete("/mocks", mocksController.deleteAll);

app.post("/login", authController.login);

app.post("/firebase/notification", fcmController.create);

app.get("/mobiles", mobileController.getAll);

app.listen(3000, () => {
  console.log("Server running at port 3000");
});

kafkaHelper.initConsumers();
