import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/favourites_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/location_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreen> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
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
        child: AnimatedOpacity(
          opacity: _visible ? 0.5 : 1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Center(
            child: SingleChildScrollView(
              child: restaurantsAsync.when(
                data: (restaurantData) {
                  setState(() {
                    _visible = true;
                  });
                  return RestaurantContents(
                      restaurantData: trimRestaurantList(restaurantData),
                      favouriteRestaurants: favouriteRestaurants);
                },
                loading: () {
                  setState(() {
                    _visible = false;
                  });
                  return const Column(
                    children: [
                      Text('Discovering restaurants near you...'),
                      Center(child: CircularProgressIndicator()),
                    ],
                  );
                },
                error: (e, _) => Text(e.toString()),
              ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Text(
            'Restaurants near you!',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        ...restaurantData.restaurants.asMap().entries.map((index) {
          final currentRestaurant = restaurantData.restaurants[index.key];
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: ListTile(
              iconColor: Theme.of(context).iconTheme.color,
              style: ListTileStyle.list,
              leading: SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: currentRestaurant.imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Text(
                  currentRestaurant.name,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              subtitle: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.1, color: Colors.black38))),
                child: Text(
                  currentRestaurant.description,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
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
            ),
          );
        })
      ],
    );
  }
}
