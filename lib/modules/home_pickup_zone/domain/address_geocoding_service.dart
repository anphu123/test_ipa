import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

/// 🗺️ Service xử lý các tác vụ liên quan đến địa chỉ và tọa độ
/// Bao gồm: geocoding, reverse geocoding, và lấy vị trí hiện tại
class AddressGeocodingService {
  // ⏱️ Thời gian chờ để tránh spam request
  static const Duration _debounceDelay = Duration(milliseconds: 1200);

  // 📏 Độ dài tối thiểu của địa chỉ để validate
  static const int _minAddressLength = 5;

  /// 📍 Chuyển đổi địa chỉ text thành tọa độ GPS (Forward Geocoding)
  /// Input: Địa chỉ dạng text (đường, phường, quận, thành phố)
  /// Output: Tọa độ latitude/longitude trên bản đồ
  static Future<GeocodingResult> geocodeAddress({
    required String streetAddress, // Địa chỉ đường/số nhà (bắt buộc)
    String? ward, // Phường/Xã (tùy chọn)
    String? district, // Quận/Huyện (tùy chọn)
    String? city, // Thành phố/Tỉnh (tùy chọn)
  }) async {
    try {
      // ✅ Kiểm tra độ dài địa chỉ tối thiểu
      if (streetAddress.trim().length < _minAddressLength) {
        return GeocodingResult.error(
          'Địa chỉ phải có ít nhất $_minAddressLength ký tự',
        );
      }

      // 🔗 Ghép các thành phần địa chỉ thành chuỗi hoàn chỉnh
      final fullAddress = _buildFullAddress(
        streetAddress: streetAddress,
        ward: ward,
        district: district,
        city: city,
      );

      print('🔍 Geocoding address: $fullAddress');

      // 🌐 Gọi API geocoding để tìm tọa độ
      final locations = await locationFromAddress(fullAddress);

      // ❌ Không tìm thấy địa chỉ
      if (locations.isEmpty) {
        return GeocodingResult.error('Không tìm thấy địa chỉ này trên bản đồ');
      }

      // ✅ Lấy kết quả đầu tiên (thường là chính xác nhất)
      final location = locations.first;
      final coordinates = LatLng(location.latitude, location.longitude);

      print(
        '📍 Found coordinates: ${location.latitude}, ${location.longitude}',
      );

      return GeocodingResult.success(
        coordinates: coordinates,
        formattedAddress: fullAddress,
      );
    } catch (e) {
      print('❌ Geocoding error: $e');
      return GeocodingResult.error('Lỗi khi kiểm tra địa chỉ: ${e.toString()}');
    }
  }

  /// 📱 Lấy vị trí hiện tại của thiết bị
  /// Yêu cầu quyền truy cập location và GPS được bật
  static Future<LocationResult> getCurrentLocation() async {
    try {
      // 🔐 Kiểm tra quyền truy cập vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // 🙋‍♂️ Yêu cầu quyền nếu chưa có
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationResult.error('Quyền truy cập vị trí bị từ chối');
        }
      }

      // 🚫 Quyền bị từ chối vĩnh viễn
      if (permission == LocationPermission.deniedForever) {
        return LocationResult.error(
          'Quyền truy cập vị trí bị từ chối vĩnh viễn. Vui lòng bật trong Settings.',
        );
      }

      // 🎯 Lấy vị trí hiện tại với độ chính xác cao
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Độ chính xác cao
        timeLimit: Duration(seconds: 10), // Timeout 10 giây
      );

      final coordinates = LatLng(position.latitude, position.longitude);

      print('📱 Current location: ${position.latitude}, ${position.longitude}');

      return LocationResult.success(
        coordinates: coordinates,
        accuracy: position.accuracy,
      );
    } catch (e) {
      print('❌ Location error: $e');
      return LocationResult.error(
        'Không thể lấy vị trí hiện tại: ${e.toString()}',
      );
    }
  }

  /// 🔄 Chuyển đổi tọa độ thành địa chỉ (Reverse Geocoding)
  /// Input: Tọa độ latitude/longitude
  /// Output: Thông tin địa chỉ (đường, phường, quận, thành phố)
  static Future<ReverseGeocodingResult> reverseGeocode(
    LatLng coordinates,
  ) async {
    try {
      // 🌐 Gọi API reverse geocoding
      final placemarks = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
        //  localeIdentifier: 'vi_VN', // 🇻🇳 Sử dụng locale Việt Nam để có kết quả tốt hơn
      );

      // ❌ Không tìm thấy thông tin địa chỉ
      if (placemarks.isEmpty) {
        return ReverseGeocodingResult.error(
          'Không thể xác định địa chỉ từ tọa độ này',
        );
      }

      final placemark = placemarks.first;

      // 🗂️ Mapping các field từ placemark sang cấu trúc địa chỉ VN
      // Dựa trên cấu trúc thực tế của API response cho Việt Nam
      String street = placemark.street ?? placemark.thoroughfare ?? '';
      String ward = placemark.subLocality ?? ''; // ⚠️ Thường empty cho VN
      String district =
          placemark.subAdministrativeArea ??
          placemark.name ??
          placemark.locality ??
          '';
      String city = placemark.administrativeArea ?? '';

      // 🔍 Debug logging để hiểu cấu trúc dữ liệu
      print('🗺️ Raw placemark data:');
      print('  street: ${placemark.street}'); // Tên đường
      print('  name: ${placemark.name}'); // Tên khu vực
      print('  subLocality: ${placemark.subLocality}'); // Phường (thường empty)
      print('  locality: ${placemark.locality}'); // Quận (thường empty)
      print(
        '  subAdministrativeArea: ${placemark.subAdministrativeArea}',
      ); // Quận (chính)
      print(
        '  administrativeArea: ${placemark.administrativeArea}',
      ); // Thành phố

      print('🎯 Mapped results:');
      print('  street: "$street"');
      print('  ward: "$ward"');
      print('  district: "$district"');
      print('  city: "$city"');

      return ReverseGeocodingResult.success(
        street: street,
        ward: ward,
        district: district,
        city: city,
        country: placemark.country ?? '',
        formattedAddress: _formatPlacemark(placemark),
      );
    } catch (e) {
      print('❌ Reverse geocoding error: $e');
      return ReverseGeocodingResult.error(
        'Lỗi khi xác định địa chỉ: ${e.toString()}',
      );
    }
  }

  /// 🔗 Ghép các thành phần địa chỉ thành chuỗi hoàn chỉnh cho geocoding
  /// Format: "Số nhà/Đường, Phường, Quận, Thành phố, Vietnam"
  static String _buildFullAddress({
    required String streetAddress,
    String? ward,
    String? district,
    String? city,
  }) {
    String fullAddress = streetAddress.trim();

    // 📍 Thêm từng thành phần nếu có
    if (ward?.isNotEmpty == true) {
      fullAddress += ', $ward';
    }
    if (district?.isNotEmpty == true) {
      fullAddress += ', $district';
    }
    if (city?.isNotEmpty == true) {
      fullAddress += ', $city';
    }

    // 🇻🇳 Thêm "Vietnam" để tăng độ chính xác
    fullAddress += ', Vietnam';

    return fullAddress;
  }

  /// 📝 Format placemark thành địa chỉ dễ đọc
  /// Ghép các thành phần có sẵn thành chuỗi địa chỉ hoàn chỉnh
  static String _formatPlacemark(Placemark placemark) {
    final parts = <String>[];

    // 🏗️ Thêm từng thành phần nếu không rỗng
    if (placemark.street?.isNotEmpty == true) parts.add(placemark.street!);
    if (placemark.subLocality?.isNotEmpty == true)
      parts.add(placemark.subLocality!);
    if (placemark.locality?.isNotEmpty == true) parts.add(placemark.locality!);
    if (placemark.administrativeArea?.isNotEmpty == true)
      parts.add(placemark.administrativeArea!);
    if (placemark.country?.isNotEmpty == true) parts.add(placemark.country!);

    return parts.join(', ');
  }

  /// 📡 Kiểm tra xem dịch vụ định vị có được bật không
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// 🔐 Lấy trạng thái quyền truy cập vị trí
  static Future<LocationPermission> getLocationPermission() async {
    return await Geolocator.checkPermission();
  }
}

/// 📍 Kết quả của quá trình geocoding (địa chỉ → tọa độ)
class GeocodingResult {
  final bool isSuccess; // ✅ Thành công hay thất bại
  final LatLng? coordinates; // 📍 Tọa độ tìm được
  final String? formattedAddress; // 📝 Địa chỉ đã format
  final String? error; // ❌ Thông báo lỗi (nếu có)

  GeocodingResult._({
    required this.isSuccess,
    this.coordinates,
    this.formattedAddress,
    this.error,
  });

  /// ✅ Tạo kết quả thành công
  factory GeocodingResult.success({
    required LatLng coordinates,
    required String formattedAddress,
  }) {
    return GeocodingResult._(
      isSuccess: true,
      coordinates: coordinates,
      formattedAddress: formattedAddress,
    );
  }

  /// ❌ Tạo kết quả lỗi
  factory GeocodingResult.error(String error) {
    return GeocodingResult._(isSuccess: false, error: error);
  }
}

/// 📱 Kết quả của việc lấy vị trí hiện tại
class LocationResult {
  final bool isSuccess; // ✅ Thành công hay thất bại
  final LatLng? coordinates; // 📍 Tọa độ hiện tại
  final double? accuracy; // 🎯 Độ chính xác (mét)
  final String? error; // ❌ Thông báo lỗi (nếu có)

  LocationResult._({
    required this.isSuccess,
    this.coordinates,
    this.accuracy,
    this.error,
  });

  /// ✅ Tạo kết quả thành công
  factory LocationResult.success({
    required LatLng coordinates,
    double? accuracy,
  }) {
    return LocationResult._(
      isSuccess: true,
      coordinates: coordinates,
      accuracy: accuracy,
    );
  }

  /// ❌ Tạo kết quả lỗi
  factory LocationResult.error(String error) {
    return LocationResult._(isSuccess: false, error: error);
  }
}

/// 🔄 Kết quả của reverse geocoding (tọa độ → địa chỉ)
class ReverseGeocodingResult {
  final bool isSuccess; // ✅ Thành công hay thất bại
  final String? street; // 🛣️ Tên đường/số nhà
  final String? ward; // 🏘️ Phường/Xã
  final String? district; // 🏙️ Quận/Huyện
  final String? city; // 🌆 Thành phố/Tỉnh
  final String? country; // 🇻🇳 Quốc gia
  final String? formattedAddress; // 📝 Địa chỉ đầy đủ
  final String? error; // ❌ Thông báo lỗi (nếu có)

  ReverseGeocodingResult._({
    required this.isSuccess,
    this.street,
    this.ward,
    this.district,
    this.city,
    this.country,
    this.formattedAddress,
    this.error,
  });

  /// ✅ Tạo kết quả thành công
  factory ReverseGeocodingResult.success({
    required String street,
    required String ward,
    required String district,
    required String city,
    required String country,
    required String formattedAddress,
  }) {
    return ReverseGeocodingResult._(
      isSuccess: true,
      street: street,
      ward: ward,
      district: district,
      city: city,
      country: country,
      formattedAddress: formattedAddress,
    );
  }

  /// ❌ Tạo kết quả lỗi
  factory ReverseGeocodingResult.error(String error) {
    return ReverseGeocodingResult._(isSuccess: false, error: error);
  }
}
