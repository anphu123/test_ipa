class FavouriteProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final String category;
  final String brand;       // Thương hiệu
  final String series;      // Dòng sản phẩm
  final String timeAgo;
  final String imgBrand ; // Hình ảnh thương hiệu

  FavouriteProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.brand,
    required this.series,
    required this.timeAgo,
    required this.imgBrand  // Hình ảnh thương hiệu, có thể để trống nếu không cần
  });

  // ✅ Dùng khi load từ JSON/API
  factory FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavouriteProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? 0,
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      series: json['series'] ?? '',
      timeAgo: json['timeAgo'] ?? '', imgBrand: '',
    );
  }

  // ✅ Dùng khi cần convert sang JSON để lưu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'brand': brand,
      'series': series,
      'timeAgo': timeAgo,
    };
  }
}
