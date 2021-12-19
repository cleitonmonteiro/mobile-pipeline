class SubscriptionModel {
  SubscriptionModel(
    this.track,
    this.userId,
    this.mobileId,
    this.latitude,
    this.longitude,
    this.distanceToNotifier,
  );

  bool? track;
  String? userId;
  String? mobileId;
  double? latitude;
  double? longitude;
  double? distanceToNotifier;

  SubscriptionModel.fromJson(Map<String, dynamic> json)
      : mobileId = json['mobileId'],
        track = json['track'],
        userId = json['userId'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        distanceToNotifier = json['distanceToNotifier'];

  Map<String, dynamic> toJson() => {
        'mobileId': mobileId,
        'track': track,
        'userId': userId,
        'latitude': latitude,
        'longitude': longitude,
        'distanceToNotifier': distanceToNotifier,
      };
}
