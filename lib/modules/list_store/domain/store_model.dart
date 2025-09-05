class StoreModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  String distance;
  final String openHours;
  final List<String> services;
  final List<String> categories;
  final String district;

  StoreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.distance = '0.0',
    required this.openHours,
    required this.services,
    required this.categories,
    required this.district,
  });
}
