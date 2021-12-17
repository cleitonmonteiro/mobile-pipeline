const Mobile = require("../models/mobile.model");

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
  getAll,
};
