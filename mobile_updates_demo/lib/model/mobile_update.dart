class MobileUpdateModel {
  MobileUpdateModel(
    this.latitude,
    this.longitude,
    this.accuracy,
    this.provider,
    this.timestamp,
    this.mobileId,
  );

  double latitude;
  double longitude;
  double accuracy;
  double timestamp;
  String provider;
  String mobileId;

  MobileUpdateModel.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        accuracy = json['accuracy'],
        timestamp = json['timestamp'],
        provider = json['provider'],
        mobileId = json['mobileId'];

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'accuracy': accuracy,
        'timestamp': timestamp,
        'provider': provider,
        'mobileId': mobileId,
      };
}
