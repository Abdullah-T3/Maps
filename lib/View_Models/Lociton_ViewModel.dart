import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../Helpers/LocationPermissionHandler.dart';
import '../Model/Location_Model.dart';


class LocationViewModel extends ChangeNotifier {
  final LocationModel _locationState = LocationModel();
  final String apiKey = "5b3ce3597851110001cf62480653e40a024247fab1741c886038f9ee";
  final LocationPermissionHandler _permissionHandler = LocationPermissionHandler();

  LocationModel get locationState => _locationState;

  LocationViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    bool hasPermission = await _permissionHandler.checkPermission();
    if (hasPermission) {
      _getLocation();
    } else {
      // Handle the case when permission is not granted
      print("Location permission not granted.");
    }
  }

  Future<void> _getLocation() async {
    var location = Location();
    try {
      var userLocation = await location.getLocation();
      _locationState.setCurrentLocation(
        LatLng(userLocation.latitude!, userLocation.longitude!),
      );
      Marker marker = Marker(
        width: 60,
        height: 60,
        point: LatLng(userLocation.latitude!, userLocation.longitude!),
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
        )
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      _locationState.setCurrentLocation(
        LatLng(newLocation.latitude!, newLocation.longitude!),
      );
      notifyListeners();
    });
  }

  Future<void> getRoute(LatLng destination) async {
    if (_locationState.currentLocation == null) return;

    final start = _locationState.currentLocation!;

    final Response response = await get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final List<dynamic> points = data['features'][0]['geometry']['coordinates'];
      _locationState.setRoutePoints(
          points.map((point) => LatLng(point[1], point[0])).toList());
      _locationState.addMarker(
        Marker(
          width: 60,
          height: 60,
          point: destination,
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      );
      notifyListeners();
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  void addDestination(LatLng point) {
    // Add the new destination marker
    _locationState.addMarker(
      Marker(
        point: point,
        width: 60,
        height: 60,
        child: const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
      ),
    );
    notifyListeners();
    getRoute(point);
  }

  void clearMarkers() {
    _locationState.clearMarkers();
    notifyListeners();
  }
}
