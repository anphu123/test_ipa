import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/phone_number_model.dart';

class PhoneNumberService {
  static const String _phoneNumbersKey = 'saved_phone_numbers';
  static const String _currentPhoneKey = 'current_phone_number';

  final GetStorage _storage = GetStorage();

  /// Lưu số điện thoại hiện tại
  Future<void> saveCurrentPhoneNumber(PhoneNumberModel phoneNumber) async {
    try {
      await _storage.write(_currentPhoneKey, phoneNumber.toJson());
      print('✅ Đã lưu số điện thoại hiện tại: ${phoneNumber.phoneNumber}');
    } catch (e) {
      print('❌ Lỗi khi lưu số điện thoại hiện tại: $e');
    }
  }

  /// Lấy số điện thoại hiện tại
  PhoneNumberModel? getCurrentPhoneNumber() {
    try {
      final data = _storage.read(_currentPhoneKey);
      if (data != null) {
        return PhoneNumberModel.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      print('❌ Lỗi khi lấy số điện thoại hiện tại: $e');
    }
    return null;
  }

  /// Thêm số điện thoại vào danh sách đã lưu
  Future<void> addPhoneNumberToHistory(PhoneNumberModel phoneNumber) async {
    try {
      final List<PhoneNumberModel> phoneNumbers = getSavedPhoneNumbers();

      // Kiểm tra xem số điện thoại đã tồn tại chưa
      final existingIndex = phoneNumbers.indexWhere(
        (p) => p.phoneNumber == phoneNumber.phoneNumber,
      );

      if (existingIndex != -1) {
        // Cập nhật thông tin nếu đã tồn tại
        phoneNumbers[existingIndex] = phoneNumber;
        print('📝 Đã cập nhật số điện thoại: ${phoneNumber.phoneNumber}');
      } else {
        // Thêm mới nếu chưa tồn tại
        phoneNumbers.add(phoneNumber);
        print('➕ Đã thêm số điện thoại mới: ${phoneNumber.phoneNumber}');
      }

      // Lưu danh sách cập nhật
      final jsonList = phoneNumbers.map((p) => p.toJson()).toList();
      await _storage.write(_phoneNumbersKey, jsonList);

    } catch (e) {
      print('❌ Lỗi khi thêm số điện thoại vào lịch sử: $e');
    }
  }

  /// Lấy danh sách số điện thoại đã lưu
  List<PhoneNumberModel> getSavedPhoneNumbers() {
    try {
      final data = _storage.read(_phoneNumbersKey);
      if (data != null && data is List) {
        return data
            .map((item) => PhoneNumberModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
    } catch (e) {
      print('❌ Lỗi khi lấy danh sách số điện thoại: $e');
    }
    return [];
  }

  /// Xóa số điện thoại khỏi lịch sử
  Future<void> removePhoneNumber(String phoneNumber) async {
    try {
      final List<PhoneNumberModel> phoneNumbers = getSavedPhoneNumbers();
      phoneNumbers.removeWhere((p) => p.phoneNumber == phoneNumber);

      final jsonList = phoneNumbers.map((p) => p.toJson()).toList();
      await _storage.write(_phoneNumbersKey, jsonList);

      print('🗑️ Đã xóa số điện thoại: $phoneNumber');
    } catch (e) {
      print('❌ Lỗi khi xóa số điện thoại: $e');
    }
  }

  /// Xóa tất cả số điện thoại
  Future<void> clearAllPhoneNumbers() async {
    try {
      await _storage.remove(_phoneNumbersKey);
      await _storage.remove(_currentPhoneKey);
      print('🧹 Đã xóa tất cả số điện thoại');
    } catch (e) {
      print('❌ Lỗi khi xóa tất cả số điện thoại: $e');
    }
  }

  /// Lấy số điện thoại được sử dụng gần đây nhất
  PhoneNumberModel? getMostRecentPhoneNumber() {
    final phoneNumbers = getSavedPhoneNumbers();
    if (phoneNumbers.isEmpty) return null;

    // Sắp xếp theo thời gian tạo giảm dần
    phoneNumbers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return phoneNumbers.first;
  }

  /// Kiểm tra số điện thoại có hợp lệ không
  bool isValidPhoneNumber(String phoneNumber) {
    // Regex cho số điện thoại Việt Nam
    final RegExp phoneRegex = RegExp(r'^(0|\+84)[3|5|7|8|9][0-9]{8}$');
    return phoneRegex.hasMatch(phoneNumber.replaceAll(' ', '').replaceAll('-', ''));
  }

  /// Format số điện thoại
  String formatPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(' ', '').replaceAll('-', '');
    if (cleanNumber.length == 10 && cleanNumber.startsWith('0')) {
      return '${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4, 7)} ${cleanNumber.substring(7)}';
    }
    return phoneNumber;
  }

  /// Lưu thông tin xác nhận (bao gồm số điện thoại)
  Future<void> saveConfirmationInfo({
    required String phoneNumber,
    required String contactName,
    required String method,
    required String dateTime,
    String? address,
    String? storeName,
    String? note,
  }) async {
    try {
      final phoneModel = PhoneNumberModel(
        phoneNumber: phoneNumber,
        contactName: contactName,
        createdAt: DateTime.now(),
        note: 'Xác nhận $method - $dateTime${note != null ? ' - $note' : ''}',
      );

      // Lưu số điện thoại hiện tại
      await saveCurrentPhoneNumber(phoneModel);

      // Thêm vào lịch sử
      await addPhoneNumberToHistory(phoneModel);

      // Lưu thông tin xác nhận chi tiết
      final confirmationData = {
        'phoneNumber': phoneNumber,
        'contactName': contactName,
        'method': method,
        'dateTime': dateTime,
        'address': address,
        'storeName': storeName,
        'note': note,
        'confirmedAt': DateTime.now().toIso8601String(),
      };

      await _storage.write('last_confirmation', confirmationData);

      print('✅ Đã lưu thông tin xác nhận hoàn tất');

    } catch (e) {
      print('❌ Lỗi khi lưu thông tin xác nhận: $e');
    }
  }
}
