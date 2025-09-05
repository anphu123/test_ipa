enum VoucherStatus { available, used, expired }

class VoucherModel {
  final String? id;
  final String amount;
  final String condition;
  final String expiry;
  final String? expiryDate;
  final VoucherStatus status;
  final int? discountAmount;
  final int? discountPercentage;

  VoucherModel({
    this.id,
    required this.amount,
    required this.condition,
    required this.expiry,
    this.expiryDate,
    this.status = VoucherStatus.available,
    this.discountAmount,
    this.discountPercentage,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      amount: json['amount'],
      condition: json['condition'],
      expiry: json['expiry'],
      expiryDate: json['expiryDate'],
      status: VoucherStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => VoucherStatus.available,
      ),
      discountAmount: json['discountAmount'],
      discountPercentage: json['discountPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'condition': condition,
      'expiry': expiry,
      'expiryDate': expiryDate,
      'status': status.name,
      'discountAmount': discountAmount,
      'discountPercentage': discountPercentage,
    };
  }

  VoucherModel copyWith({
    String? id,
    String? amount,
    String? condition,
    String? expiry,
    String? expiryDate,
    VoucherStatus? status,
    int? discountAmount,
    int? discountPercentage,
  }) {
    return VoucherModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      condition: condition ?? this.condition,
      expiry: expiry ?? this.expiry,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }

  bool get isPercentageDiscount => discountPercentage != null && discountPercentage! > 0;
  bool get isFixedDiscount => discountAmount != null && discountAmount! > 0;
  bool get isExpired => status == VoucherStatus.expired;
  bool get isUsed => status == VoucherStatus.used;
  bool get isAvailable => status == VoucherStatus.available;
}