const { Kafka } = require("kafkajs");

const kafka = new Kafka({
  clientId: "service-i1",
  brokers: ["172.17.0.5:9092"],
});

async function initConsumers() {
  console.log(
    "🚀 ~ file: kafka.js ~ line 9 Starting kafka consumers fo topics [device-notifier]"
  );
  const notifierConsumer = kafka.consumer({ groupId: "notifier" });
  const locationConsumer = kafka.consumer({ groupId: "location" });

  await notifierConsumer.connect();
  await locationConsumer.connect();

  await notifierConsumer.subscribe({
    topic: "device-notifier",
    // topic: "mobile-location",
    fromBeginning: true,
  });
  await locationConsumer.subscribe({
    // topic: "device-notifier",
    topic: "mobile-location",
    fromBeginning: true,
  });

  const callback = async ({ topic, partition, message }) => {
    console.log({
      fromConsumer: true,
      topic,
      message: { ...message, value: message.value.toString() },
    });
  };

  await notifierConsumer.run({
    eachMessage: callback,
  });

  await locationConsumer.run({
    eachMessage: callback,
  });
}

module.exports = kafka;
module.exports.initConsumers = initConsumers;
