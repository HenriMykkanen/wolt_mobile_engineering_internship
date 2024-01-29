import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
class Restaurant with _$Restaurant {
  factory Restaurant({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'short_description') required String description,
    // defaults to empty list
    @Default([]) List<Restaurant> restaurants,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}

class Restaurants {
  Restaurants({required this.restaurants});
  List<Restaurant> restaurants;

  factory Restaurants.fromNestedJson(Map<String, dynamic> json) {
    final jsonAsDynamicList = json['sections'][1]['items'] as List<dynamic>;
    final restaurants = jsonAsDynamicList
        .map((section) => Restaurant.fromJson(section['venue']))
        .toList();
    return Restaurants(restaurants: restaurants);
  }
}
