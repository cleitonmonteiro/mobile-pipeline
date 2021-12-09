const { v4 } = require("uuid");

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
  const { latitude, longitude, provider, accuracy, mobileId, timestamp } =
    req.body;

  console.log("Sending data to Kafka: ", {
    latitude,
    longitude,
    provider,
    accuracy,
    mobileId,
    timestamp,
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
          timestamp,
        }),
        key: v4(),
      },
    ],
  });
  await producer.disconnect();
  res.status(201).send();
};

module.exports = {
  create,
  initConsumer,
};
