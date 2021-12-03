const { v4 } = require("uuid");
// const Mobile = require("../models/mobile.model");

const { Kafka } = require("kafkajs");

const kafka = new Kafka({
  clientId: "service-i1",
  brokers: ["localhost:9092"],
});

const producer = kafka.producer();

async function initConsumer() {
  const consumer = kafka.consumer({ groupId: "location" });

  await consumer.connect();
  await consumer.subscribe({ topic: "mobile-location", fromBeginning: true });

  await consumer.run({
    eachMessage: async ({ topic, partition, message }) => {
      console.log({
        fromConsumer: true,
        message: { ...message, value: message.value.toString() },
      });
    },
  });
}

const create = async (req, res) => {
  // Validate request
  const { latitude, longitude, provider, accuracy, mobileId } = req.body;
  console.log("Sending data to Kafka: ", {
    latitude,
    longitude,
    provider,
    accuracy,
    mobileId,
  });

  await producer.connect();
  await producer.send({
    topic: "mobile-location",
    messages: [
      {
        value: JSON.stringify({
          latitude,
          longitude,
          provider,
          accuracy,
          mobileId,
        }),
        key: v4(),
      },
    ],
  });
  await producer.disconnect();
};

module.exports = {
  create,
  initConsumer,
};
