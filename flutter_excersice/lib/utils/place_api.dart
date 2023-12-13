import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:flutter_excersice/models/map_model.dart';
import 'package:flutter_excersice/models/place_model.dart';

//  chrome.exe --user-data-dir="C:/Chrome dev session" --disable-web-security

class PlaceApi {
  final apiKey = dotenv.maybeGet('GOOGLE_MAPS_KEY', fallback: null);

  Future<List<MapModel>> fetchMapModel(
      String input, LocationData currentLocation) async {
    try {
      if (apiKey != null) {
        Dio dio = Dio();
        final options = Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': '*',
            'Access-Control-Allow-Headers': '*'
          },
        );
        // ignore: unnecessary_null_comparison
        final queryParameters = {
          'input': input,
          'key': apiKey,
          'location':
              '${currentLocation.latitude},${currentLocation.longitude}',
          'radius': 500
        };

        final response = await dio.post(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json',
            options: options,
            queryParameters: queryParameters);
        if (response.statusCode == 200) {
          final result = response.data;
          if (result['status'] == 'OK') {
            // Componer sugerencias en una lista
            return (result['predictions'] as List)
                .map<MapModel>((place) => MapModel.fromJson(place))
                .toList();
          }
          if (result['status'] == 'ZERO_RESULTS') {
            return [];
          }
          throw Exception(result['error_message']);
        } else {
          throw Exception('Failed to fetch suggestion');
        }
      } else {
        throw Exception('Invalid API Key');
      }
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          // Manejar errores de conexión, como la pérdida de conexión
          throw Exception('Error de conexión: $e');
        } else {
          // Manejar otros errores de Dio
          throw Exception('Error durante la solicitud: $e');
        }
      } else {
        // Manejar otros tipos de excepciones
        throw Exception('Error general: $e');
      }
    }
  }

  Future<PlaceModel> fetchPlaceModel(String placeId) async {
    try {
      final url = 'https://places.googleapis.com/v1/places/$placeId';
      final parameters = {
        'fields': 'id,displayName,googleMapsUri,location,formattedAddress',
        'key': apiKey,
      };
      final response = await Dio().get(url, queryParameters: parameters);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final place = PlaceModel.fromJson(data);
        return place;
      } else {
        throw 'Failed to fetch place: ${response.statusMessage}';
      }
    } catch (e) {
      throw 'Error during place fetch: $e';
    }
  }
}
