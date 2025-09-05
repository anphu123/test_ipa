class SavedProductModel {
  final String id;
  final String name;                   // Tên sản phẩm
  final String imageUrl;              // Ảnh sản phẩm
  final int price;                    // Giá bán
  final int discountAmount;          // Số tiền giảm giá
  final String conditionLabel;       // Ví dụ: "99%" hoặc "95%"
  final String screenStatus;         // Màn hình: "Màn hình bình thường"
  final String scratchStatus;        // Tình trạng trầy: "Không trầy xước"
  final String tag;                  // Ví dụ: "Top 1 điện thoại bán chạy nhất"
  final String sellerName;           // Tên người bán (XiaoYu)
  final String sellerAvatar;         // Ảnh đại diện người bán
  final bool isOutOfStock;           // Trạng thái hết hàng

  SavedProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.discountAmount,
    required this.conditionLabel,
    required this.screenStatus,
    required this.scratchStatus,
    required this.tag,
    required this.sellerName,
    required this.sellerAvatar,
    this.isOutOfStock = false,
  });
}
