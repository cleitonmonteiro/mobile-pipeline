class UserModel {
  UserModel(
    this.id,
    this.token,
    this.username,
  );
  String id;
  String username;
  String token;

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        id = json['_id'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'token': token,
        'username': username,
      };
}
