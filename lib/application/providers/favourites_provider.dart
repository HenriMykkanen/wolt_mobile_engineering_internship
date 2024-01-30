import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritesListProvider =
    StateNotifierProvider<FavoriteController, List<String>>((ref) {
  return FavoriteController();
});

class FavoriteController extends StateNotifier<List<String>> {
  // builder
  FavoriteController() : super([]) {
    _fetchFavourites();
  }

  // initial fetch
  _fetchFavourites() async {
    return state;
  }

  // add fav
  void addToFav(String restaurantID) {
    if (restaurantID == '') {
      return;
    }
    state = [...state, restaurantID];
  }

  // remove fav
  void removeFromFav(String restaurantID) {
    state = state.where((id) => id != restaurantID).toList();
  }
}
