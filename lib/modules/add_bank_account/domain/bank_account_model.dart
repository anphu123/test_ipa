class BankAccountModel {
  final String bankName;
  final String accountNumber;
  final String accountHolder;
  final String issueDate;

  BankAccountModel({
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.issueDate,
  });

  Map<String, dynamic> toJson() => {
    'bankName': bankName,
    'accountNumber': accountNumber,
    'accountHolder': accountHolder,
    'issueDate': issueDate,
  };

  factory BankAccountModel.fromJson(Map<String, dynamic> json) => BankAccountModel(
    bankName: json['bankName'],
    accountNumber: json['accountNumber'],
    accountHolder: json['accountHolder'],
    issueDate: json['issueDate'],
  );
}
