import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolt_mobile_engineering_internship/data/location_repository.dart';

part 'current_location_provider.g.dart';

// Provider to hold the current user location and trigger UI updates when it changes

@Riverpod(keepAlive: true)
class CurrentLocationNotifier extends AsyncNotifier<Position> {
  @override
  // get initial location
  FutureOr<Position> build() async {
    return ref.watch(locationRepositoryProvider).determinePosition();
  }

  // watch for location changes
  Future<void> getCurrentLocation() async {
    final locationRepository = ref.read(locationRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(locationRepository.determinePosition);
  }
}
