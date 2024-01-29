import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/current_location_provider.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/restaurants.provider.dart';
import 'package:wolt_mobile_engineering_internship/data/restaurants_repository.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant_data.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsAsync = ref.watch(restaurantsNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Restaurants'),
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
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                  restaurantData.restaurants[index.key].name),
                              subtitle: Text(restaurantData
                                  .restaurants[index.key].description),
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
