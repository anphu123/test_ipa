enum OrderStatus { all, processing, completed, canceled }
enum PurchaseSource {
  twoHand,
  consignment,
}
extension PurchaseSourceX on PurchaseSource {
  String get label {
    switch (this) {
      case PurchaseSource.twoHand:
        return '2Hand thu mua';
      case PurchaseSource.consignment:
        return 'Ký gửi nền tảng';
    }
  }
}

class PurchaseOrderModel {
  final String id;
  final String productName;
  final String productImage;
  final PurchaseSource source; // ví dụ: '2Hand thu mua', 'Ký gửi nền tảng'
  final String statusText;
  final OrderStatus status;

  PurchaseOrderModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.source,
    required this.statusText,
    required this.status,
  });
}
