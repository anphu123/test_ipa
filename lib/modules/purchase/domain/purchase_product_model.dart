class PurchaseProductModel {
  final String name;
  final int price; // bạn có thể dùng int nếu cần xử lý số
  final String discount;
  final String bonus;
  final String image;

  PurchaseProductModel({
    required this.name,
    required this.price,
    required this.discount,
    required this.bonus,
    required this.image,
  });
}
