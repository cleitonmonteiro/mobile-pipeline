const { Kafka } = require("kafkajs");

const firebaseHelper = require("./firebase");
const User = require("../models/user.model");

const kafka = new Kafka({
  clientId: "service-i1",
  // TODO: change to get from env
  brokers: ["localhost:9092"],
});

async function initConsumers() {
  console.log(
    "🚀 ~ file: kafka.js ~ line 9 Starting kafka consumers fo topics [device-notifier, mobile-location]"
  );
  const locationConsumer = kafka.consumer({ groupId: "location" });
  await locationConsumer.connect();
  await locationConsumer.subscribe({
    topic: "mobile-location",
    fromBeginning: false,
  });
  await locationConsumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      console.log({
        fromConsumer: true,
        topic,
        message: { ...message, value: message.value.toString() },
      });
    },
  });

  const notifierConsumer = kafka.consumer({ groupId: "notifier" });
  await notifierConsumer.connect();
  await notifierConsumer.subscribe({
    topic: "device-notifier",
    fromBeginning: false,
  });
  await notifierConsumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      console.log({
        fromConsumer: true,
        topic,
        message: { ...message, value: message.value.toString() },
      });

      const notification = {
        title: "Mobile update",
      };
      const data = message.value.toString();
      const userId = JSON.parse(data).userId;
      const user = await User.findById(userId);
      if (user == null) {
        console.log("Cannot get the user token with id", userId);
        return;
      }

      const registrationToken = user.token;
      console.log("Sendind message to token: ", registrationToken);

      firebaseHelper
        .sendMessage(registrationToken, notification, { json: data })
        .then((response) => {
          console.log("Sent!");
        })
        .catch((error) => {
          console.error(error);
        });
    },
  });
}

module.exports = kafka;
module.exports.initConsumers = initConsumers;
