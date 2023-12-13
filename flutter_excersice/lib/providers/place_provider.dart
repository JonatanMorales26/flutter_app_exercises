import 'package:flutter/material.dart';
import 'package:flutter_excersice/models/map_model.dart';
import 'package:flutter_excersice/models/place_model.dart';
import 'package:flutter_excersice/utils/location.dart';
import 'package:flutter_excersice/utils/place_api.dart';
import 'package:location/location.dart';

class PlaceProvider extends ChangeNotifier {
  PlaceApi places = PlaceApi();
  List<MapModel> locations = [];
  LocationData? currentLocation;
  PlaceModel? placeModel;

  void fetchSuggestions(String input, String lang, LocationData locationData) async {
    placeModel = null;
    locations = await places.fetchMapModel(input, locationData);
    notifyListeners();
  }

  void fetchPlaceById(String placeId) async {
    placeModel = await places.fetchPlaceModel(placeId);
    notifyListeners();
  }

  void getCurrentLocation() async {
    currentLocation = await getCurrentLocationDevice();
    notifyListeners();
  }

}
