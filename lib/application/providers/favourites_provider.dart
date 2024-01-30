import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favouritesListProvider =
    StateNotifierProvider<FavoriteController, List<String>>((ref) {
  return FavoriteController();
});

class FavoriteController extends StateNotifier<List<String>> {
  // constructor
  FavoriteController() : super([]) {
    _fetchFavourites();
  }

  // SHARED PREFENCES
  // initial fetch from shared preferences
  _fetchFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavourites = prefs.getStringList('favourites') ?? [];
    state = savedFavourites;
  }

  // save to local storage
  _saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favourites', state);
  }

  // LOCAL STATE
  // add fav
  void addToFav(String restaurantID) {
    if (restaurantID == '') {
      return;
    }
    state = [...state, restaurantID];
    _saveFavourites();
  }

  // remove fav
  void removeFromFav(String restaurantID) {
    state = state.where((id) => id != restaurantID).toList();
    _saveFavourites();
  }
}

class SavedPreferencesFavourites {
  // set favourites
  Future<void> setFavourites(String favourite, String restaurantID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('favourites', restaurantID);
  }

// get favourites
  Future<String> getFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('favourites').toString();
  }
}
