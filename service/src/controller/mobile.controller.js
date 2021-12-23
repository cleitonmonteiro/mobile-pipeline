const Mobile = require("../models/mobile.model");

const create = async (req, res) => {
  const { description } = req.body;

  if (!description) {
    return res.status(400).send({
      message: "Cannot creat a new mobile witout description.",
    });
  }

  const mobile = await Mobile.create({ description });
  if (mobile) {
    return res.status(201).send(mobile);
  }
  return res.status(400).send({
    message: "Cannot creat a new mobile.",
  });
};

const getAll = async (req, res) => {
  const mobiles = await Mobile.find({});
  if (mobiles) {
    console.log("Mobiles: ", mobiles);
    return res.send(mobiles);
  }
  return res.status(400).send({
    message: "Cannot get the mobiles.",
  });
};

module.exports = {
  create,
  getAll,
};
