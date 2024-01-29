class WoltAPI {
  WoltAPI();

  static const String _apiBaseUrl = "restaurant-api.wolt.com";
  static const String _apiPath = "/v1";

  Uri restaurants(lat, lon) => _buildUri(
        endpoint: "/pages/restaurants",
        parametersBuilder: () => restaurantQueryParameters(lat, lon),
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> restaurantQueryParameters(double lat, double lon) => {
        "lat": lat.toString(),
        "lon": lon.toString(),
      };
}
