import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider =
    StateNotifierProvider<LocationController, Position>((ref) {
  return LocationController();
});

class LocationController extends StateNotifier<Position> {
  // constructor
  LocationController() : super(_setInitialLocation());

  static Position _setInitialLocation() {
    return Position(
      longitude: 24.930599,
      latitude: 60.170187,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }

  void setLocation(Position newLocation) {
    state = newLocation;
  }
}
