import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_mobile_engineering_internship/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:wolt_mobile_engineering_internship/data/api_exception.dart';
import 'package:wolt_mobile_engineering_internship/domain/restaurant.dart';

class HttpRestaurantRepository {
  HttpRestaurantRepository({required this.api, required this.client});
  final WoltAPI api;
  final http.Client client;

  Future<Restaurant> getRestaurantData(
          {required String lat, required String lon}) =>
      _getData(
          uri: api.restaurants(lat, lon),
          builder: (data) => Restaurant.fromJSON(data));

  Future<GenericType> _getData<GenericType>({
    required Uri uri,
    required GenericType Function(dynamic data) builder,
  }) async {
    try {
      final response = await client.get(uri);
      print(response.body);
      switch (response.statusCode) {
        case 200: // 200 OK - Indicates that the request has succeeded
          final data = json.decode(response.body);
          // print(data);
          return builder(data);
        case 404: // 404 Not Found - The server can not find the requested resource
          throw RestaurantNotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

final restaurantRepositoryProvider = Provider<HttpRestaurantRepository>((ref) {
  return HttpRestaurantRepository(api: WoltAPI(), client: http.Client());
});
