// Helper function to trim the amount of restaurants to a max of 15
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

Restaurants trimRestaurantList(Restaurants original) {
  final restaurantsList = original.restaurants;
  if (restaurantsList.length > 15) {
    final trimmedList = restaurantsList.sublist(0, 15);
    return Restaurants(restaurants: trimmedList);
  } else {
    return original;
  }
}
