const firebase = require("../config/firebase");

const defaultOptions = {
  priority: "high",
  timeToLive: 60 * 60 * 24,
};

const create = async (req, res) => {
  const { registrationToken, notification, data } = req.body;
  if (!registrationToken || !notification) {
    return res
      .status(404)
      .send({ message: "Send the registrationToken and notification." });
  }

  const message = data ? { notification, data } : { notification };

  firebase.admin
    .messaging()
    .sendToDevice(registrationToken, message, defaultOptions)
    .then((response) => {
      console.log(
        "🚀 ~ file: fcm.controller.js ~ line 22 ~ .then ~ response",
        response
      );
      res
        .status(200)
        .send({ message: "Notification sent successfully", data: response });
    })
    .catch((error) => {
      console.error(error);
      res
        .status(400)
        .send({ message: "Cannot send a notification", error: error.message });
    });
};

module.exports = {
  create,
};
