import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/current_location_provider.dart';
import 'package:wolt_mobile_engineering_internship/data/location_repository.dart';
import 'package:wolt_mobile_engineering_internship/data/restaurants_repository.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/current_location_provider.dart';

part 'restaurants.provider.g.dart';

@Riverpod(keepAlive: true)
class RestaurantsNotifier extends AsyncNotifier<Restaurants> {
  Future<Restaurants> _fetchRestaurants() async {
    final restaurantsRepository = ref.watch(restaurantRepositoryProvider);
    final location = ref.watch(currentLocationNotifierProvider);
    final lat = location.value!.latitude;
    final lon = location.value!.longitude;
    return restaurantsRepository.getRestaurants(lat: lat, lon: lon);
  }

  @override
  FutureOr<Restaurants> build() {
    // Load initial restaurant data from restaurant repository
    return _fetchRestaurants();
  }
}
