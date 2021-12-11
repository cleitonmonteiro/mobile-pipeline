const admin = require("firebase-admin");

const serviceAccount = require("../../fcm-credential.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mobile-pipeline-kafka.firebaseio.com",
});

module.exports.admin = admin;
