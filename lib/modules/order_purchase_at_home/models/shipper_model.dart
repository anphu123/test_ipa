class ShipperModel {
  final String id;
  final String name;
  final String phone;
  final double rating;
  final int totalOrders;
  final String vehicleType;
  final String vehiclePlate;
  final double latitude;
  final double longitude;
  final String status; // 'on_the_way', 'arrived', 'picking_up'
  final String estimatedArrival;
  final String avatar;

  ShipperModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.rating,
    required this.totalOrders,
    required this.vehicleType,
    required this.vehiclePlate,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.estimatedArrival,
    this.avatar = '',
  });

  factory ShipperModel.fromJson(Map<String, dynamic> json) {
    return ShipperModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalOrders: json['total_orders'] ?? 0,
      vehicleType: json['vehicle_type'] ?? '',
      vehiclePlate: json['vehicle_plate'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'on_the_way',
      estimatedArrival: json['estimated_arrival'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'rating': rating,
      'total_orders': totalOrders,
      'vehicle_type': vehicleType,
      'vehicle_plate': vehiclePlate,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'estimated_arrival': estimatedArrival,
      'avatar': avatar,
    };
  }

  // Tạo shipper mẫu
  static ShipperModel createSample() {
    return ShipperModel(
      id: 'shipper_001',
      name: 'Nguyễn Văn Tài',
      phone: '0817433226',
      rating: 4.8,
      totalOrders: 1247,
      vehicleType: 'Xe máy',
      vehiclePlate: '59H1-12345',
      latitude: 10.762622 + 0.02, // Xa hơn để thấy rõ movement
      longitude: 106.660172 + 0.02,
      status: 'on_the_way',
      estimatedArrival: '15 phút',
      avatar: '',
    );
  }

  // Copy with method để update thông tin
  ShipperModel copyWith({
    String? id,
    String? name,
    String? phone,
    double? rating,
    int? totalOrders,
    String? vehicleType,
    String? vehiclePlate,
    double? latitude,
    double? longitude,
    String? status,
    String? estimatedArrival,
    String? avatar,
  }) {
    return ShipperModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      rating: rating ?? this.rating,
      totalOrders: totalOrders ?? this.totalOrders,
      vehicleType: vehicleType ?? this.vehicleType,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
      avatar: avatar ?? this.avatar,
    );
  }

  // Getter cho status display
  String get statusDisplay {
    switch (status) {
      case 'on_the_way':
        return 'Đang đến';
      case 'arrived':
        return 'Đã đến';
      case 'picking_up':
        return 'Đang lấy hàng';
      default:
        return 'Đang đến';
    }
  }

  // Getter cho status color
  String get statusColor {
    switch (status) {
      case 'on_the_way':
        return 'warning';
      case 'arrived':
        return 'success';
      case 'picking_up':
        return 'info';
      default:
        return 'warning';
    }
  }
}
