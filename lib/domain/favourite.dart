import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

class FavouriteRestaurant {
  const FavouriteRestaurant({required this.restaurantID});
  final String restaurantID;

  factory FavouriteRestaurant.fromJson(Map<String, dynamic> json) {
    final restaurantID = json['restaurantID'] as String;
    return FavouriteRestaurant(restaurantID: restaurantID);
  }
  Map<String, dynamic> toJson() => {
        'restaurantID': restaurantID,
      };
}
