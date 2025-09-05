class StaffModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String completedOrders;
  final String rating;
  final String position;
  final String experience;
  final String specialty;
  final String avatar;
  final bool isVerified;
  final String storeId;
  final String workingHours;
  final List<String> languages;
  final double averageRating;
  final int totalReviews;

  StaffModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.completedOrders,
    required this.rating,
    this.position = 'Chuyên gia thu mua',
    this.experience = '2 năm',
    this.specialty = 'Điện thoại, Laptop',
    this.avatar = '',
    this.isVerified = true,
    this.storeId = '',
    this.workingHours = '8:00 - 18:00',
    this.languages = const ['Tiếng Việt'],
    this.averageRating = 4.8,
    this.totalReviews = 1250,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      completedOrders: json['completedOrders'] ?? '0',
      rating: json['rating'] ?? '0',
      position: json['position'] ?? 'Chuyên gia thu mua',
      experience: json['experience'] ?? '2 năm',
      specialty: json['specialty'] ?? 'Điện thoại, Laptop',
      avatar: json['avatar'] ?? '',
      isVerified: json['isVerified'] ?? true,
      storeId: json['storeId'] ?? '',
      workingHours: json['workingHours'] ?? '8:00 - 18:00',
      languages: List<String>.from(json['languages'] ?? ['Tiếng Việt']),
      averageRating: (json['averageRating'] ?? 4.8).toDouble(),
      totalReviews: json['totalReviews'] ?? 1250,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'completedOrders': completedOrders,
      'rating': rating,
      'position': position,
      'experience': experience,
      'specialty': specialty,
      'avatar': avatar,
      'isVerified': isVerified,
      'storeId': storeId,
      'workingHours': workingHours,
      'languages': languages,
      'averageRating': averageRating,
      'totalReviews': totalReviews,
    };
  }

  StaffModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? completedOrders,
    String? rating,
    String? position,
    String? experience,
    String? specialty,
    String? avatar,
    bool? isVerified,
    String? storeId,
    String? workingHours,
    List<String>? languages,
    double? averageRating,
    int? totalReviews,
  }) {
    return StaffModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      completedOrders: completedOrders ?? this.completedOrders,
      rating: rating ?? this.rating,
      position: position ?? this.position,
      experience: experience ?? this.experience,
      specialty: specialty ?? this.specialty,
      avatar: avatar ?? this.avatar,
      isVerified: isVerified ?? this.isVerified,
      storeId: storeId ?? this.storeId,
      workingHours: workingHours ?? this.workingHours,
      languages: languages ?? this.languages,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  // Utility methods
  String get initials {
    if (name.isEmpty) return 'S';
    
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String get formattedCompletedOrders {
    try {
      final number = int.parse(completedOrders.replaceAll(',', ''));
      if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      }
      return completedOrders;
    } catch (e) {
      return completedOrders;
    }
  }

  String get experienceLevel {
    try {
      final number = int.parse(completedOrders.replaceAll(',', ''));
      if (number >= 10000) {
        return 'Chuyên gia cấp cao';
      } else if (number >= 5000) {
        return 'Chuyên gia';
      } else if (number >= 1000) {
        return 'Có kinh nghiệm';
      } else {
        return 'Mới';
      }
    } catch (e) {
      return 'Chuyên gia';
    }
  }

  bool get isHighRated {
    try {
      final ratingValue = int.parse(rating);
      return ratingValue >= 95;
    } catch (e) {
      return false;
    }
  }

  @override
  String toString() {
    return 'StaffModel(id: $id, name: $name, rating: $rating, completedOrders: $completedOrders)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StaffModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
