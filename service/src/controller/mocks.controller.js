const Mobile = require("../models/mobile.model");
const MobileSubscription = require("../models/subscription.model");

const mobileMocks = require("../mocks/mobiles");
const { makeData } = require("../mocks/subscription");

const create = (req, res) => {
  const result = {};

  Mobile.insertMany(mobileMocks)
    .then((mobileData) => {
      console.log("Created mobiles mocks: ", mobileData);
      result.mobile = mobileData;

      MobileSubscription.insertMany(makeData(mobileData.map((m) => m._id)))
        .then((subs) => {
          console.log("Created subs mocks: ", subs);
          result.subs = subs;
          res.send(result);
        })
        .catch((err) => {
          res.status(500).send({
            message: err.message + "Some error occurred when try insert subs.",
          });
        });
    })
    .catch((err) => {
      res.status(500).send({
        message: err.message + "Some error occurred when try insert mobiles.",
      });
    });
};

const deleteAll = (req, res) => {
  Mobile.deleteMany({})
    .then((mobiles) => {
      MobileSubscription.deleteMany({})
        .then((subs) => {
          res.send({
            message: `${
              mobiles.deletedCount + subs.deletedCount
            } all data deleted successfully!`,
          });
        })
        .catch((err) => {
          res.status(500).send({
            message:
              err.message || "Some error occurred while removing all orders.",
          });
        });
    })
    .catch((err) => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while removing all orders.",
      });
    });
};

module.exports = {
  create,
  deleteAll,
};
