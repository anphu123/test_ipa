import 'merch_product_model.dart';

class ArtistModel {
  final String id;
  final String name;
  final String imageUrl;
  final int productCount;
  bool isFollowing;
  final List<MerchProduct> merchProducts;

  ArtistModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.productCount = 0,
    this.isFollowing = false,
    this.merchProducts = const [],
  });
}
