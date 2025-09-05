import 'package:get_storage/get_storage.dart';

/// Service quản lý dữ liệu địa chỉ booking
class BookingAddressService {
  final GetStorage _storage = GetStorage();
  static const String _storageKey = 'pickup_booking_list';

  /// Lấy danh sách địa chỉ đã lưu
  List<Map<String, dynamic>> getBookingList() {
    final data = _storage.read(_storageKey);
    if (data != null && data is List) {
      return data.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }

  /// Lưu danh sách địa chỉ
  void saveBookingList(List<Map<String, dynamic>> bookingList) {
    _storage.write(_storageKey, bookingList);
  }

  /// Thêm địa chỉ mới
  void addBookingData(Map<String, dynamic> data) {
    final bookingList = getBookingList();
    
    // Thêm timestamp và id
    data['createdAt'] = DateTime.now().millisecondsSinceEpoch;
    data['id'] = DateTime.now().millisecondsSinceEpoch.toString();
    
    bookingList.add(data);
    saveBookingList(bookingList);
  }

  /// Xóa địa chỉ theo id
  bool removeBookingData(String id) {
    final bookingList = getBookingList();
    final initialLength = bookingList.length;
    
    bookingList.removeWhere((item) => item['id'] == id);
    
    if (bookingList.length < initialLength) {
      saveBookingList(bookingList);
      return true;
    }
    return false;
  }

  /// Xóa nhiều địa chỉ theo danh sách id
  int removeMultipleBookingData(Set<String> ids) {
    final bookingList = getBookingList();
    final initialLength = bookingList.length;
    
    bookingList.removeWhere((item) => ids.contains(item['id']));
    
    final removedCount = initialLength - bookingList.length;
    if (removedCount > 0) {
      saveBookingList(bookingList);
    }
    return removedCount;
  }

  /// Xóa tất cả địa chỉ
  void clearAllBookingData() {
    _storage.remove(_storageKey);
  }

  /// Đặt địa chỉ mặc định
  bool setDefaultAddress(String id) {
    final bookingList = getBookingList();
    bool found = false;
    
    // Bỏ default của tất cả địa chỉ khác
    for (var booking in bookingList) {
      if (booking['id'] == id) {
        booking['isDefault'] = true;
        found = true;
      } else {
        booking['isDefault'] = false;
      }
    }
    
    if (found) {
      saveBookingList(bookingList);
    }
    return found;
  }

  /// Lấy địa chỉ mặc định
  Map<String, dynamic>? getDefaultAddress() {
    final bookingList = getBookingList();
    try {
      return bookingList.firstWhere((item) => item['isDefault'] == true);
    } catch (e) {
      return null;
    }
  }

  /// Kiểm tra địa chỉ có phải mặc định không
  bool isDefaultAddress(String id) {
    final defaultAddress = getDefaultAddress();
    return defaultAddress?['id'] == id;
  }

  /// Lấy địa chỉ theo id
  Map<String, dynamic>? getBookingById(String id) {
    final bookingList = getBookingList();
    try {
      return bookingList.firstWhere((item) => item['id'] == id);
    } catch (e) {
      return null;
    }
  }

  /// Cập nhật thông tin địa chỉ
  bool updateBookingData(String id, Map<String, dynamic> updatedData) {
    final bookingList = getBookingList();
    
    for (int i = 0; i < bookingList.length; i++) {
      if (bookingList[i]['id'] == id) {
        // Giữ lại id và createdAt
        updatedData['id'] = id;
        updatedData['createdAt'] = bookingList[i]['createdAt'];
        bookingList[i] = updatedData;
        saveBookingList(bookingList);
        return true;
      }
    }
    return false;
  }

  /// Đếm số lượng địa chỉ
  int getBookingCount() {
    return getBookingList().length;
  }

  /// Kiểm tra có địa chỉ nào không
  bool hasBookings() {
    return getBookingCount() > 0;
  }

  /// Lấy địa chỉ trong khu vực
  List<Map<String, dynamic>> getInZoneAddresses() {
    final bookingList = getBookingList();
    return bookingList.where((item) => item['isInZone'] == true).toList();
  }

  /// Lấy địa chỉ ngoài khu vực
  List<Map<String, dynamic>> getOutOfZoneAddresses() {
    final bookingList = getBookingList();
    return bookingList.where((item) => item['isInZone'] != true).toList();
  }

  /// Sắp xếp danh sách theo thời gian tạo (mới nhất trước)
  List<Map<String, dynamic>> getSortedBookingList() {
    final bookingList = getBookingList();
    bookingList.sort((a, b) {
      final aTime = a['createdAt'] ?? 0;
      final bTime = b['createdAt'] ?? 0;
      return bTime.compareTo(aTime); // Mới nhất trước
    });
    return bookingList;
  }

  /// Tìm kiếm địa chỉ theo từ khóa
  List<Map<String, dynamic>> searchBookings(String keyword) {
    if (keyword.isEmpty) return getBookingList();
    
    final bookingList = getBookingList();
    final lowerKeyword = keyword.toLowerCase();
    
    return bookingList.where((item) {
      final fullAddress = (item['fullAddress'] ?? '').toLowerCase();
      final contactName = (item['contactName'] ?? '').toLowerCase();
      final phoneNumber = (item['phoneNumber'] ?? '').toLowerCase();
      
      return fullAddress.contains(lowerKeyword) ||
             contactName.contains(lowerKeyword) ||
             phoneNumber.contains(lowerKeyword);
    }).toList();
  }
}
