class MobileModel {
  MobileModel(
    this.id,
    this.description,
  );
  String id;
  String description;

  MobileModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'description': description,
      };
}
