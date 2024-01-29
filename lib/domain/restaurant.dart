class Restaurant {
  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.url});
  final int id;
  final String name;
  final String description;
  final String url;

  factory Restaurant.fromJSON(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final description = json['description'];
    final url = json['url'];
    return Restaurant(id: id, name: name, description: description, url: url);
  }
}
