const { v4 } = require("uuid");
const Problem = require("../models/problem.model");

const { Kafka, CompressionTypes } = require("kafkajs");

const kafka = new Kafka({
  clientId: "service-i1",
  brokers: ["localhost:9092"],
});

const producer = kafka.producer();

async function initConsumer() {
  const consumer = kafka.consumer({ groupId: "problems" });

  await consumer.connect();
  await consumer.subscribe({ topic: "wordcount", fromBeginning: true });

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
  const { description } = req.body;
  if (!description) {
    res.status(400).send({ message: "Description can not be empty!" });
    return;
  }

  const newProblem = new Problem({
    description,
  });

  await producer.connect();
  await producer.send({
    topic: "wordcount",
    messages: [
      {
        value: JSON.stringify({
          provider: "FUSED",
          accuracy: 12,
          latitude: 12,
          longitude: 12,
          timestamp: 12,
        }),
        key: v4(),
      },
    ],
  });
  await producer.disconnect();

  newProblem
    .save(newProblem)
    .then((data) => {
      console.log("Created problem ", data);
      res.send(data);
    })
    .catch((err) => {
      res.status(500).send({
        message: err.message || "Some error occurred.",
      });
    });
};

module.exports = {
  create,
  initConsumer,
};
