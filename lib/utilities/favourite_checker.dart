// Helper function just to check if restaurant is in the favourites list
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

bool isRestaurantFavourited(Restaurant restaurant, List<String> favorites) {
  if (favorites.contains(restaurant.id)) {
    return true;
  } else {
    return false;
  }
}
