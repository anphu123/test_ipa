class CreditCardModel {
  final String cardHolder;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String address;
  final String postalCode;

  CreditCardModel({
    required this.cardHolder,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.address,
    required this.postalCode,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(
      cardHolder: json['cardHolder'],
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
      address: json['address'] ?? '',
      postalCode: json['postalCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'address': address,
      'postalCode': postalCode,
    };
  }
}
