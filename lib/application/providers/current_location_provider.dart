import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolt_mobile_engineering_internship/data/location_repository.dart';

part 'current_location_provider.g.dart';

// Provider to hold the current user location and trigger UI updates when it changes

@Riverpod(keepAlive: true)
class CurrentLocationNotifier extends AsyncNotifier<Position> {
  Future<Position> _fetchPosition() async {
    return ref.watch(locationRepositoryProvider).determinePosition();
  }

  @override
  // get initial location
  FutureOr<Position> build() async {
    return _fetchPosition();
  }

  // watch for location changes
  Future<void> getCurrentLocation() async {
    final locationRepository = ref.read(locationRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(locationRepository.determinePosition);
  }

  Future<double> currentLatitude() async {
    final locationRepository = ref.watch(locationRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(locationRepository.determinePosition);
    final latitude = state.value!.latitude;
    return latitude;
  }

  Future<double> currentLongitude() async {
    final locationRepository = ref.watch(locationRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(locationRepository.determinePosition);
    final longitude = state.value!.longitude;
    return longitude;
  }
}
