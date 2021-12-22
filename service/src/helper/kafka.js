const { Kafka } = require("kafkajs");

const kafka = new Kafka({
  clientId: "service-i1",
  // TODO: change to get from env
  brokers: ["localhost:9092"],
});

async function initConsumers() {
  console.log(
    "🚀 ~ file: kafka.js ~ line 9 Starting kafka consumers fo topics [device-notifier, mobile-location]"
  );
  const notifierConsumer = kafka.consumer({ groupId: "notifier" });
  const locationConsumer = kafka.consumer({ groupId: "location" });

  await notifierConsumer.connect();
  await locationConsumer.connect();

  await notifierConsumer.subscribe({
    topic: "device-notifier",
    fromBeginning: false,
  });
  await locationConsumer.subscribe({
    topic: "mobile-location",
    fromBeginning: false,
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
