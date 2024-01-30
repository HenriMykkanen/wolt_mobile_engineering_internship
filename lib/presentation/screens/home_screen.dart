import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/favourites_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant_data.dart';
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
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
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
                                  onTap: !isFavourite(
                                          currentRestaurant, favourites)
                                      ?
                                      // add fav
                                      () {
                                          ref
                                              .read(favouritesListProvider
                                                  .notifier)
                                              .addToFav(currentRestaurant.id);
                                        }
                                      :
                                      // remove fav
                                      () {
                                          ref
                                              .read(favouritesListProvider
                                                  .notifier)
                                              .removeFromFav(
                                                  currentRestaurant.id);
                                        },
                                  child:
                                      isFavourite(currentRestaurant, favourites)
                                          ? const Icon(Icons.favorite)
                                          : const Icon(
                                              Icons.favorite_border_outlined)),
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

bool isFavourite(Restaurant restaurant, List<String> favorites) {
  if (favorites.contains(restaurant.id)) {
    return true;
  } else {
    return false;
  }
}
