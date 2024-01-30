import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/current_location_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/favourites_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/data/location_repository.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouritesListProvider);
    final restaurantsAsync = ref.watch(restaurantsNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: restaurantsAsync.when(
              data: (restaurantData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: Text(
                        '15 Restaurants near you!',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    ...restaurantData.restaurants.asMap().entries.map((index) {
                      final currentRestaurant =
                          restaurantData.restaurants[index.key];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: ListTile(
                          style: ListTileStyle.list,
                          title: Text(
                            currentRestaurant.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text(currentRestaurant.description),
                          trailing: GestureDetector(
                              onTap: isFavourite(currentRestaurant, favourites)
                                  ?
                                  // add fav
                                  () {
                                      ref
                                          .read(favouritesListProvider.notifier)
                                          .removeFromFav(currentRestaurant.id);
                                    }
                                  :
                                  // remove fav
                                  () {
                                      ref
                                          .read(favouritesListProvider.notifier)
                                          .addToFav(currentRestaurant.id);
                                    },
                              child: isFavourite(currentRestaurant, favourites)
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border_outlined)),
                          leading: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: currentRestaurant.imageURL,
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
              loading: () => const Center(child: CircularProgressIndicator()),
              // TODO this actually throws a null check error because provider dependancies aren't initialized
              error: (e, _) => Text(e.toString()),
            ),
          ),
        ),
      ),
    );
  }
}

bool isFavourite(Restaurant restaurant, List<String> favorites) {
  if (favorites.contains(restaurant.id)) {
    return true;
  } else {
    return false;
  }
}
