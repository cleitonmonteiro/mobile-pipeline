const Subscrition = require("../models/subscription.model");

const create = async (req, res) => {
  const { mobileId, userId, track, distanceToNotifier, latitudde, longitude } =
    req.body;

  if (!mobileId || !userId) {
    return res.status(404).send({
      message: "The mobileId or userId cannot be empty.",
    });
  }

  const sub = await Subscrition.create({
    mobileId,
    userId,
    track,
    distanceToNotifier,
    latitudde,
    longitude,
  });

  if (sub) {
    console.log("Create new subscription: ", {
      mobileId,
      userId,
      track,
      distanceToNotifier,
      latitudde,
      longitude,
    });
    return res.status(201).send(sub);
  }

  return res
    .status(400)
    .send({ message: "Cannot create the new subscription." });
};

module.exports = {
  create,
};
