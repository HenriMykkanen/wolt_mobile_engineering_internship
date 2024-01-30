import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
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
                Position kuopio = Position(
                    longitude: 27.6780,
                    latitude: 62.8928,
                    timestamp: DateTime.now(),
                    accuracy: 0,
                    altitude: 0,
                    altitudeAccuracy: 0,
                    heading: 0,
                    headingAccuracy: 0,
                    speed: 0,
                    speedAccuracy: 0);
                ref.watch(locationProvider.notifier).setLocation(kuopio);
              },
              child: Text('To Kuopio')),
          ElevatedButton(
              onPressed: () {
                Position helsinki = Position(
                    longitude: 24.930599,
                    latitude: 60.170187,
                    timestamp: DateTime.now(),
                    accuracy: 0,
                    altitude: 0,
                    altitudeAccuracy: 0,
                    heading: 0,
                    headingAccuracy: 0,
                    speed: 0,
                    speedAccuracy: 0);
                ref.watch(locationProvider.notifier).setLocation(helsinki);
              },
              child: Text('To Helsinki'))
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
                  onTap: isRestaurantFavourited(
                          currentRestaurant, favouriteRestaurants)
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
