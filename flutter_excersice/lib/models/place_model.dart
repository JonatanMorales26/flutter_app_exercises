import 'dart:convert';

import 'package:flutter_excersice/models/display_name_model.dart';
import 'package:flutter_excersice/models/location_model.dart';

class PlaceModel {
  final String id;
  final String formattedAddress;
  final LocationModel location;
  final String googleMapsUri;
  final DisplayName displayName;

  PlaceModel({
    required this.id,
    required this.formattedAddress,
    required this.location,
    required this.googleMapsUri,
    required this.displayName,
  });

  factory PlaceModel.fromRawJson(String str) =>
      PlaceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        id: json["id"],
        formattedAddress: json["formattedAddress"],
        location: LocationModel.fromJson(json["location"]),
        googleMapsUri: json["googleMapsUri"],
        displayName: DisplayName.fromJson(json["displayName"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "formattedAddress": formattedAddress,
        "location": location.toJson(),
        "googleMapsUri": googleMapsUri,
        "displayName": displayName.toJson(),
      };
}
