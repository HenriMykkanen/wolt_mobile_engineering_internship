import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

class RestaurantData {
  RestaurantData(
      {required this.id, required this.name, required this.description});
  final String id;
  final String name;
  final String description;

  factory RestaurantData.from(Restaurant restaurant) {
    return RestaurantData(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description);
  }
}
