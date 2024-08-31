import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationModel with ChangeNotifier {
  LatLng? _currentLocation;
  List<LatLng> _routePoints = [];
  List<Marker> _markers = [];

  LatLng? get currentLocation => _currentLocation;
  List<LatLng> get routePoints => _routePoints;
  List<Marker> get markers => _markers;

  void setCurrentLocation(LatLng location) {
    _currentLocation = location;
    notifyListeners();
  }

  void setRoutePoints(List<LatLng> points) {
    _routePoints = points;
    notifyListeners();
  }

  void addMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void clearMarkers() {
    _markers.clear();
    notifyListeners();
  }
}
