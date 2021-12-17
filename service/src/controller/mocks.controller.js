const User = require("../models/user.model");
const Mobile = require("../models/mobile.model");
const Subscription = require("../models/subscription.model");

const userMocks = require("../mocks/users");
const mobileMocks = require("../mocks/mobiles");
const { makeData } = require("../mocks/subscription");

const create = async (req, res) => {
  const mobiles = await Mobile.insertMany(mobileMocks);
  // const users = await User.insertMany(userMocks);
  // const subs = await Subscription.insertMany(
  //   makeData(
  //     mobiles.map((m) => m._id),
  //     users.map((u) => u._id)
  //   )
  // );
  res.send({
    mobiles,
    // users,
    // subs,
  });
};

const deleteAll = async (req, res) => {
  const users = await User.deleteMany({});
  const mobiles = await Mobile.deleteMany({});
  const subs = await Subscription.deleteMany({});
  res.send({
    mobiles,
    users,
    subs,
  });
};

module.exports = {
  create,
  deleteAll,
};
