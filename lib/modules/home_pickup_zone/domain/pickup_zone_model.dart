import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickupZoneModel {
  final String id;
  final String name;
  final String description;
  final LatLng center;
  final List<LatLng> boundaries;
  final bool isActive;
  final String operatingHours;
  final List<String> supportedServices;

  PickupZoneModel({
    required this.id,
    required this.name,
    required this.description,
    required this.center,
    required this.boundaries,
    this.isActive = true,
    required this.operatingHours,
    required this.supportedServices,
  });
}

class LocationModel {
  final String id;
  final String name;
  final String district;
  final LatLng coordinates;
  final bool hasPickupService;

  LocationModel({
    required this.id,
    required this.name,
    required this.district,
    required this.coordinates,
    this.hasPickupService = false,
  });
}

class BookingRequestModel {
  final String customerName;
  final String phoneNumber;
  final String address;
  final LatLng location;
  final DateTime preferredTime;
  final List<String> deviceTypes;
  final String? notes;

  BookingRequestModel({
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.location,
    required this.preferredTime,
    required this.deviceTypes,
    this.notes,
  });
}