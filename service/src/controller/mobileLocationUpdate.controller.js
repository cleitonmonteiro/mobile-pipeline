const { v4 } = require("uuid");
const kafka = require("../helper/kafka");

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

  const producer = kafka.producer();
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
};
