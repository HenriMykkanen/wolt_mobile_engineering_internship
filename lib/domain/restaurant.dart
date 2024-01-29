class Restaurant {
  const Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageURL});
  final String id;
  final String name;
  final String description;
  final String imageURL;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final id = json['venue']['id'] as String;
    final name = json['venue']['name'] as String;
    final description = json['venue']['short_description'] as String;
    final imageURL = json['image']['url'] as String;
    return Restaurant(
        id: id, name: name, description: description, imageURL: imageURL);
  }
}

class Restaurants {
  Restaurants({required this.restaurants});
  List<Restaurant> restaurants;

  factory Restaurants.fromNestedJson(Map<String, dynamic> json) {
    final jsonAsDynamicList = json['sections'][1]['items'] as List<dynamic>;
    final restaurants = jsonAsDynamicList
        .map((section) => Restaurant.fromJson(section))
        .toList();
    return Restaurants(restaurants: restaurants);
  }
}
