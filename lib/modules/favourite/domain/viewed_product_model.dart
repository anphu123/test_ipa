class ViewedProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final int price;
  final String conditionLabel;
  final DateTime viewedAt; // 👈 thêm ngày xem

  ViewedProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.conditionLabel,
    required this.viewedAt,
  });
}
