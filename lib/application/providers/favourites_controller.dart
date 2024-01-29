import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolt_mobile_engineering_internship/domain/favourite.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

class FavouritesController {
  addFavouriteRestaurant(String restaurant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(restaurant, true);
  }

  removeFavouriteRestaurant(String restaurant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(restaurant);
  }

  Future<bool> isFavouriteRestaurant(String restaurant) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFavourite = prefs.containsKey(restaurant);
    return isFavourite;
  }
}
