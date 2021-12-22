class PushNotificationData {
  PushNotificationData(
    this.userId,
    this.mobileId,
    this.fromTrack,
    this.latitude,
    this.longitude,
  );

  String userId;
  String mobileId;
  bool fromTrack;
  double latitude;
  double longitude;

  PushNotificationData.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        fromTrack = json['fromTrack'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        mobileId = json['mobileId'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'fromTrack': fromTrack,
        'latitude': latitude,
        'longitude': longitude,
        'mobileId': mobileId,
      };
}
