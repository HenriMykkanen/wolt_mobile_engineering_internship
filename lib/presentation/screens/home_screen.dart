import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/favourites_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsAsync = ref.watch(restaurantsNotifierProvider);
    final favouritesController = FavouritesController();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: Text(
                    '15 Restaurants near you!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                restaurantsAsync.when(
                  data: (restaurantData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...restaurantData.restaurants
                            .asMap()
                            .entries
                            .map((index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: ListTile(
                              style: ListTileStyle.list,
                              title: Text(
                                restaurantData.restaurants[index.key].name,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(restaurantData
                                  .restaurants[index.key].description),
                              trailing: GestureDetector(
                                  onTap: () {
                                    favouritesController.addFavouriteRestaurant(
                                        restaurantData
                                            .restaurants[index.key].id);
                                  },
                                  child: isFavouriteOrNot(restaurantData
                                      .restaurants[index.key].id)),
                              leading: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: restaurantData
                                        .restaurants[index.key].imageURL,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text(e.toString()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantContents extends ConsumerWidget {
  const RestaurantContents({super.key, required this.data});
  final RestaurantData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = data.name;
    final description = data.description;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Text(name),
          title: Text(description),
        )
      ],
    );
  }
}

Icon isFavouriteOrNot(String restaurantID) {
  final favouritesController = FavouritesController();
  if (favouritesController.isFavouriteRestaurant(restaurantID) == true) {
    return Icon(Icons.favorite);
  } else {
    return Icon(Icons.favorite_border_outlined);
  }
}
