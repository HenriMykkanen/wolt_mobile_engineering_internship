import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/application/providers/current_location_provider.dart';
import 'package:wolt_mobile_engineering_internship/data/restaurants_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocationAsync = ref.watch(currentLocationNotifierProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              currentLocationAsync.when(
                  data: (data) {
                    ref.watch(restaurantRepositoryProvider).getRestaurantData(
                        lat: data.latitude.toString(),
                        lon: data.longitude.toString());
                    return Text(
                        'Longitude  ${data.longitude} Latitude ${data.latitude}');
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (e, _) => Text(e.toString())),
            ],
          ),
        ),
      ),
    );
  }
}
