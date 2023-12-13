class MapModel {
  final String placeId;
  final String description;

  MapModel({required this.placeId, required this.description});

  Map<String, dynamic> toJson() {
    return {'place_id': placeId, 'description': description};
  }

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
        placeId: json['place_id'], description: json['description']);
  }
}
