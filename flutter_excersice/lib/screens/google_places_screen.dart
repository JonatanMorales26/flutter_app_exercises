import 'package:flutter/material.dart';
import 'package:flutter_excersice/models/place_model.dart';
import 'package:flutter_excersice/providers/place_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GooglePlacesScreen extends StatelessWidget {
  final TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PlaceProvider placeProvider = Provider.of<PlaceProvider>(context);
    final place = placeProvider.placeModel;
    final currentLocation = placeProvider.currentLocation;
    if (currentLocation == null) {
      placeProvider.getCurrentLocation();
    }
    final viewMap = place == null
        ? LocationsView(placeProvider: placeProvider)
        : MapView(placeModel: place);
    return Scaffold(
      appBar: AppBar(title: const Text('Places Api'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: placeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Place',
              ),
              onChanged: (input) {
                if (currentLocation != null) {
                  placeProvider.fetchSuggestions(input, 'es', currentLocation);
                }
              },
            ),
            const SizedBox(height: 8),
            viewMap
          ],
        ),
      ),
    );
  }
}

class MapView extends StatelessWidget {
  final PlaceModel placeModel;

  const MapView({super.key, required this.placeModel});

  @override
  Widget build(BuildContext context) {
    final marker = Marker(
      markerId: MarkerId(placeModel.displayName.text),
      position:
          LatLng(placeModel.location.latitude, placeModel.location.longitude),
      infoWindow: InfoWindow(
        title: placeModel.displayName.text,
        snippet: placeModel.formattedAddress,
      ),
    );
    return Expanded(
      child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
                placeModel.location.latitude, placeModel.location.longitude),
            zoom: 15.0,
          ),
          markers: {marker}),
    );
  }
}

class LocationsView extends StatelessWidget {
  const LocationsView({super.key, required this.placeProvider});

  final PlaceProvider placeProvider;

  @override
  Widget build(BuildContext context) {
    final locations = placeProvider.locations;
    return Expanded(
      child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                placeProvider.fetchPlaceById(locations[index].placeId);
              },
              child: ListTile(
                leading: const Icon(Icons.place),
                trailing: const Icon(Icons.arrow_forward_ios),
                title: Text(locations[index].description),
                subtitle: Text(locations[index].placeId),
              ),
            );
          }),
    );
  }
}
