import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/location_provider.dart';
import 'package:wolt_mobile_engineering_internship/data/restaurants_repository.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

part 'restaurants.provider.g.dart';

@Riverpod(keepAlive: true)
class RestaurantsNotifier extends AsyncNotifier<Restaurants> {
  Future<Restaurants> _fetchRestaurants() async {
    final restaurantsRepository = ref.watch(restaurantRepositoryProvider);
    final location = ref.watch(locationProvider);
    final lat = location.latitude;
    final lon = location.longitude;
    return restaurantsRepository.getRestaurants(lat: lat, lon: lon);
  }

  @override
  FutureOr<Restaurants> build() {
    // Load initial restaurant data from restaurant repository
    return _fetchRestaurants();
  }
}
