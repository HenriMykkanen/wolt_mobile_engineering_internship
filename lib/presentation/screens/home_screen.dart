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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Restaurants'),
              restaurantsAsync.when(
                data: (restaurantData) => Container(
                  child: Text(restaurantData.restaurants[0].name),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text(e.toString()),
              )
            ],
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
