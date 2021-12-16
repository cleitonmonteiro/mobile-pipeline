const admin = require("firebase-admin");

const serviceAccount = require("../../fcm-credential.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mobile-pipeline-kafka.firebaseio.com",
});

const defaultMessageOptions = {
  priority: "high",
  timeToLive: 60 * 60 * 24,
};

const sendMessage = (registrationToken, notification, data) => {
  const message = data ? { notification, data } : { notification };

  return admin
    .messaging()
    .sendToDevice(registrationToken, message, defaultMessageOptions);
};

module.exports = {
  sendMessage,
};
