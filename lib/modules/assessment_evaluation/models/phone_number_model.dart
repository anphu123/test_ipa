class PhoneNumberModel {
  final String phoneNumber;
  final String contactName;
  final DateTime createdAt;
  final String? note;

  PhoneNumberModel({
    required this.phoneNumber,
    required this.contactName,
    required this.createdAt,
    this.note,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'contactName': contactName,
      'createdAt': createdAt.toIso8601String(),
      'note': note,
    };
  }

  // Create from JSON
  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberModel(
      phoneNumber: json['phoneNumber'] ?? '',
      contactName: json['contactName'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      note: json['note'],
    );
  }

  // Copy with method
  PhoneNumberModel copyWith({
    String? phoneNumber,
    String? contactName,
    DateTime? createdAt,
    String? note,
  }) {
    return PhoneNumberModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactName: contactName ?? this.contactName,
      createdAt: createdAt ?? this.createdAt,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'PhoneNumberModel(phoneNumber: $phoneNumber, contactName: $contactName, createdAt: $createdAt, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneNumberModel &&
        other.phoneNumber == phoneNumber &&
        other.contactName == contactName &&
        other.createdAt == createdAt &&
        other.note == note;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^
        contactName.hashCode ^
        createdAt.hashCode ^
        note.hashCode;
  }
}
