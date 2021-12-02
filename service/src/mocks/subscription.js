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

function makeData(mobilesIds = []) {
  return mobilesIds.map((id, index) => ({ ...data[index], mobileId: id }));
}

module.exports = {
  makeData,
};
