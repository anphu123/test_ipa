// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class ShipperModel {
//   final String id;
//   final String name;
//   final String phone;
//   final double rating;
//   final String avatar;
//   final String vehicleType;
//   final String licensePlate;
//   final LatLng currentLocation;
//   final String? estimatedArrival;
//   final bool isOnline;
//
//   ShipperModel({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.rating,
//     required this.avatar,
//     required this.vehicleType,
//     required this.licensePlate,
//     required this.currentLocation,
//     this.estimatedArrival,
//     this.isOnline = true,
//   });
//
//   factory ShipperModel.fromJson(Map<String, dynamic> json) {
//     return ShipperModel(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       phone: json['phone'] ?? '',
//       rating: (json['rating'] ?? 0.0).toDouble(),
//       avatar: json['avatar'] ?? '',
//       vehicleType: json['vehicleType'] ?? '',
//       licensePlate: json['licensePlate'] ?? '',
//       currentLocation: LatLng(
//         (json['latitude'] ?? 0.0).toDouble(),
//         (json['longitude'] ?? 0.0).toDouble(),
//       ),
//       estimatedArrival: json['estimatedArrival'],
//       isOnline: json['isOnline'] ?? true,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'rating': rating,
//       'avatar': avatar,
//       'vehicleType': vehicleType,
//       'licensePlate': licensePlate,
//       'latitude': currentLocation.latitude,
//       'longitude': currentLocation.longitude,
//       'estimatedArrival': estimatedArrival,
//       'isOnline': isOnline,
//     };
//   }
//
//   ShipperModel copyWith({
//     String? id,
//     String? name,
//     String? phone,
//     double? rating,
//     String? avatar,
//     String? vehicleType,
//     String? licensePlate,
//     LatLng? currentLocation,
//     String? estimatedArrival,
//     bool? isOnline,
//   }) {
//     return ShipperModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       rating: rating ?? this.rating,
//       avatar: avatar ?? this.avatar,
//       vehicleType: vehicleType ?? this.vehicleType,
//       licensePlate: licensePlate ?? this.licensePlate,
//       currentLocation: currentLocation ?? this.currentLocation,
//       estimatedArrival: estimatedArrival ?? this.estimatedArrival,
//       isOnline: isOnline ?? this.isOnline,
//     );
//   }
// }
