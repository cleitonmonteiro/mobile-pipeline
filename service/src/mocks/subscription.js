const data = [
  {
    track: true,
    distanceToNotifier: 1000,
    latitude: 10.0,
    longitude: 10.0,
  },
  {
    track: false,
    distanceToNotifier: 500,
    latitude: -4.561288, // -4.560945, -37.770139 - 139 meters
    longitude: -37.768931,
  },
  {
    track: false,
    distanceToNotifier: 100,
    latitude: 100.0,
    longitude: 100.0,
  },
];

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}

function randomSelect(items = []) {
  return items[getRandomInt(0, items.length - 1)];
}

function makeData(mobiles = [], users = []) {
  return data.map((values) => ({
    ...values,
    mobileId: randomSelect(mobiles),
    userId: randomSelect(users),
  }));
}

module.exports = {
  makeData,
};
