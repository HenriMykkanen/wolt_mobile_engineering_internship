import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/favourites_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/location_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteRestaurants = ref.watch(favouritesListProvider);
    final restaurantsAsync = ref.watch(restaurantsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                ref
                    .watch(locationProvider.notifier)
                    .mockLocationChangeLoop(inputList);
              },
              child: const Text('Start loop')),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: restaurantsAsync.when(
              data: (restaurantData) {
                return RestaurantContents(
                    restaurantData: trimRestaurantList(restaurantData),
                    favouriteRestaurants: favouriteRestaurants);
              },
              loading: () => const Column(
                children: [
                  Text('Discovering restaurants near you...'),
                  Center(child: CircularProgressIndicator()),
                ],
              ),
              error: (e, _) => Text(e.toString()),
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function just to check if restaurant is in the favourites list
bool isRestaurantFavourited(Restaurant restaurant, List<String> favorites) {
  if (favorites.contains(restaurant.id)) {
    return true;
  } else {
    return false;
  }
}

// Helper function to trim the amount of restaurants to a max of 15
Restaurants trimRestaurantList(Restaurants original) {
  final restaurantsList = original.restaurants;
  if (restaurantsList.length > 15) {
    final trimmedList = restaurantsList.sublist(0, 15);
    return Restaurants(restaurants: trimmedList);
  } else {
    return original;
  }
}

class RestaurantContents extends ConsumerWidget {
  final Restaurants restaurantData;
  final List<String> favouriteRestaurants;

  const RestaurantContents(
      {super.key,
      required this.restaurantData,
      required this.favouriteRestaurants});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          final currentRestaurant = restaurantData.restaurants[index.key];
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
                  // compare restaurant to restaurantIDs stored in local storage
                  // build ontap functions and fav icons based on that
                  onTap: isRestaurantFavourited(
                          currentRestaurant, favouriteRestaurants)
                      ? () {
                          ref
                              .read(favouritesListProvider.notifier)
                              .removeFromFav(currentRestaurant.id);
                        }
                      : () {
                          ref
                              .read(favouritesListProvider.notifier)
                              .addToFav(currentRestaurant.id);
                        },
                  child: isRestaurantFavourited(
                          currentRestaurant, favouriteRestaurants)
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
  }
}
