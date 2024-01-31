import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// Provides rest of the application with a location that is held inside a Position object from geolocator lib
final locationProvider =
    StateNotifierProvider<LocationController, Position>((ref) {
  return LocationController();
});

class LocationController extends StateNotifier<Position> {
  // constructor
  LocationController() : super(_setInitialLocation());

  // initial state
  // Location here is the so called center of the world (Kuopio marketplace)
  static Position _setInitialLocation() {
    return Position(
      longitude: 27.6780,
      latitude: 62.8928,
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

  // set new location in state
  void setLocation(Position newLocation) {
    state = newLocation;
  }

  // Loops through the Position objects in the list InputList
  // repeatedly for the purposes of mocking a user whose location changes every 10 seconds
  void mockLocationChangeLoop(List<Position> inputList) {
    int index = 0;

    void updateLocation() {
      setLocation(inputList[index]);

      index = (index + 1) % inputList.length;

      Future.delayed(const Duration(seconds: 10), updateLocation);
    }

    updateLocation();
  }
}

// A list that holds a set amount (10) of different coordinates
// as per the instructions of the assignment
typedef InputList = List<Position>;

final inputList = [
  Position(
      longitude: 24.930599,
      latitude: 60.170187,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.931618,
      latitude: 60.169418,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.932906,
      latitude: 60.169818,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.935105,
      latitude: 60.170005,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.936210,
      latitude: 60.169108,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.934869,
      latitude: 60.168355,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.932562,
      latitude: 60.167560,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.931532,
      latitude: 60.168254,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.930341,
      latitude: 60.169012,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
  Position(
      longitude: 24.929569,
      latitude: 60.170085,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0),
];
