import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/favourites_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/location_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wolt_mobile_engineering_internship/presentation/animations/fade_in.dart';
import 'package:wolt_mobile_engineering_internship/utilities/favourite_checker.dart';
import 'package:wolt_mobile_engineering_internship/utilities/trim_restaurant_list.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteRestaurants = ref.watch(favouritesListProvider);
    print(favouriteRestaurants);
    final restaurantsAsync = ref.watch(restaurantsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Container(),
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
                return FadeIn(
                    child: RestaurantContents(
                        restaurantData: trimRestaurantList(restaurantData),
                        favouriteRestaurants: favouriteRestaurants));
              },
              loading: () {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Text(
                        'Discovering restaurants near you...',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const Center(
                        child: CircularProgressIndicator(
                      color: Color.fromRGBO(0, 194, 232, 100),
                    )),
                  ],
                );
              },
              error: (e, _) => Text(e.toString()),
            ),
          ),
        ),
      ),
    );
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
                // Restaurant image
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
                // Restaurant name
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    currentRestaurant.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                // Short description
                subtitle: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 0.1, color: Colors.black38))),
                  child: Text(
                    currentRestaurant.description,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                // Favourite button
                trailing: InkWell(
                  splashColor: Color.fromARGB(50, 0, 194, 232),
                  borderRadius: BorderRadius.circular(24),
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
                  child: Ink(
                    height: 40,
                    width: 40,
                    child: isRestaurantFavourited(
                            currentRestaurant, favouriteRestaurants)
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border_outlined),
                  ),
                ),
              ));
        })
      ],
    );
  }
}
