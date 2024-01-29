import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

class FavouriteRestaurant {
  const FavouriteRestaurant(
      {required this.restaurantID, required this.isFavourite});
  final String restaurantID;
  final bool isFavourite;

  factory FavouriteRestaurant.fromMap(Map<String, dynamic> map) {
    final restaurantID = map['restaurantID'] as String;
    final isFavourite = map['isFavourite'] as bool;
    return FavouriteRestaurant(
        restaurantID: restaurantID, isFavourite: isFavourite);
  }
}
