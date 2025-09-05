class VietnamAddressData {
  // Cached address data for Vietnam
  static const Map<String, List<String>> cityDistricts = {
    'Hồ Chí Minh': [
      'Quận 1', 'Quận 2', 'Quận 3', 'Quận 4', 'Quận 5', 'Quận 6', 'Quận 7',
      'Quận 8', 'Quận 9', 'Quận 10', 'Quận 11', 'Quận 12', 'Thủ Đức',
      'Bình Thạnh', 'Gò Vấp', 'Phú Nhuận', 'Tân Bình', 'Tân Phú',
      'Bình Tân', 'Hóc Môn', 'Củ Chi', 'Nhà Bè', 'Cần Giờ'
    ],
    'Hà Nội': [
      'Ba Đình', 'Hoàn Kiếm', 'Tây Hồ', 'Long Biên', 'Cầu Giấy',
      'Đống Đa', 'Hai Bà Trưng', 'Hoàng Mai', 'Thanh Xuân', 'Nam Từ Liêm',
      'Bắc Từ Liêm', 'Hà Đông', 'Sơn Tây', 'Ba Vì', 'Chương Mỹ',
      'Đan Phượng', 'Hoài Đức', 'Mê Linh', 'Mỹ Đức', 'Phú Xuyên',
      'Phúc Thọ', 'Quốc Oai', 'Sóc Sơn', 'Thạch Thất', 'Thanh Oai',
      'Thanh Trì', 'Thường Tín', 'Ứng Hòa'
    ],
    'Đà Nẵng': [
      'Hải Châu', 'Thanh Khê', 'Sơn Trà', 'Ngũ Hành Sơn', 'Liên Chiểu', 
      'Cẩm Lệ', 'Hòa Vang', 'Hoàng Sa'
    ],
    'Cần Thơ': [
      'Ninh Kiều', 'Ô Môn', 'Bình Thuỷ', 'Cái Răng', 'Thốt Nốt',
      'Vĩnh Thạnh', 'Cờ Đỏ', 'Phong Điền', 'Thới Lai'
    ],
    'Hải Phòng': [
      'Hồng Bàng', 'Ngô Quyền', 'Lê Chân', 'Hải An', 'Kiến An',
      'Đồ Sơn', 'Dương Kinh', 'Thuỷ Nguyên', 'An Dương', 'An Lão',
      'Kiến Thuỵ', 'Tiên Lãng', 'Vĩnh Bảo', 'Cát Hải', 'Bạch Long Vĩ'
    ],
  };

  static const Map<String, List<String>> districtWards = {
    // HỒ CHÍ MINH
    'Quận 1': [
      'Phường Bến Nghé', 'Phường Bến Thành', 'Phường Cầu Kho', 
      'Phường Cầu Ông Lãnh', 'Phường Cô Giang', 'Phường Đa Kao', 
      'Phường Nguyễn Cư Trinh', 'Phường Nguyễn Thái Bình',
      'Phường Phạm Ngũ Lão', 'Phường Tân Định'
    ],
    'Quận 2': [
      'Phường An Khánh', 'Phường An Lợi Đông', 'Phường An Phú', 
      'Phường Bình An', 'Phường Bình Khánh', 'Phường Bình Trưng Đông', 
      'Phường Bình Trưng Tây', 'Phường Cát Lái', 'Phường Thạnh Mỹ Lợi', 
      'Phường Thảo Điền', 'Phường Thủ Thiêm'
    ],
    'Quận 3': [
      'Phường 1', 'Phường 2', 'Phường 3', 'Phường 4', 'Phường 5', 
      'Phường 6', 'Phường 7', 'Phường 8', 'Phường 9', 'Phường 10', 
      'Phường 11', 'Phường 12', 'Phường 13', 'Phường 14'
    ],
    'Quận 4': [
      'Phường 1', 'Phường 2', 'Phường 3', 'Phường 4', 'Phường 6',
      'Phường 8', 'Phường 9', 'Phường 10', 'Phường 13', 'Phường 14',
      'Phường 15', 'Phường 16', 'Phường 18'
    ],
    'Quận 5': [
      'Phường 1', 'Phường 2', 'Phường 3', 'Phường 4', 'Phường 5',
      'Phường 6', 'Phường 7', 'Phường 8', 'Phường 9', 'Phường 10',
      'Phường 11', 'Phường 12', 'Phường 13', 'Phường 14', 'Phường 15'
    ],
    'Bình Thạnh': [
      'Phường 1', 'Phường 2', 'Phường 3', 'Phường 5', 'Phường 6', 
      'Phường 7', 'Phường 11', 'Phường 12', 'Phường 13', 'Phường 14', 
      'Phường 15', 'Phường 17', 'Phường 19', 'Phường 21', 'Phường 22', 
      'Phường 24', 'Phường 25', 'Phường 26', 'Phường 27', 'Phường 28'
    ],
    'Thủ Đức': [
      'Phường Linh Xuân', 'Phường Bình Chiểu', 'Phường Linh Trung',
      'Phường Tam Bình', 'Phường Tam Phú', 'Phường Hiệp Bình Phước',
      'Phường Hiệp Bình Chánh', 'Phường Linh Chiểu', 'Phường Linh Tây',
      'Phường Linh Đông', 'Phường Bình Thọ', 'Phường Trường Thọ'
    ],
    
    // HÀ NỘI
    'Ba Đình': [
      'Phường Phúc Xá', 'Phường Trúc Bạch', 'Phường Vĩnh Phúc',
      'Phường Cống Vị', 'Phường Liễu Giai', 'Phường Nguyễn Trung Trực',
      'Phường Quán Thánh', 'Phường Ngọc Hà', 'Phường Điện Biên',
      'Phường Đội Cấn', 'Phường Ngọc Khánh', 'Phường Kim Mã',
      'Phường Giảng Võ', 'Phường Thành Công'
    ],
    'Hoàn Kiếm': [
      'Phường Phúc Tấn', 'Phường Đồng Xuân', 'Phường Hàng Mã',
      'Phường Hàng Buồm', 'Phường Hàng Đào', 'Phường Hàng Bồ',
      'Phường Cửa Đông', 'Phường Lý Thái Tổ', 'Phường Hàng Bạc',
      'Phường Hàng Gai', 'Phường Chương Dương Độ', 'Phường Hàng Trống',
      'Phường Cửa Nam', 'Phường Hàng Bông', 'Phường Tràng Tiền',
      'Phường Trần Hưng Đạo', 'Phường Phan Chu Trinh', 'Phường Hàng Bài'
    ],
    
    // ĐÀ NẴNG
    'Hải Châu': [
      'Phường Thanh Bình', 'Phường Thuận Phước', 'Phường Thạch Thang',
      'Phường Hải Châu I', 'Phường Hải Châu II', 'Phường Phước Ninh',
      'Phường Hòa Thuận Tây', 'Phường Hòa Thuận Đông', 'Phường Nam Dương',
      'Phường Bình Hiên', 'Phường Bình Thuận', 'Phường Hòa Cường Bắc',
      'Phường Hòa Cường Nam'
    ],
    'Thanh Khê': [
      'Phường Tam Thuận', 'Phường Thanh Khê Tây', 'Phường Thanh Khê Đông',
      'Phường Xuân Hà', 'Phường Tân Chính', 'Phường Chính Gián',
      'Phường Vĩnh Trung', 'Phường Thạc Gián', 'Phường An Khê',
      'Phường Hòa Khê'
    ],
  };

  // Helper methods
  static List<String> getCities() {
    return cityDistricts.keys.toList();
  }

  static List<String> getDistrictsByCity(String city) {
    return cityDistricts[city] ?? [];
  }

  static List<String> getWardsByDistrict(String district) {
    return districtWards[district] ?? [];
  }

  static bool isCitySupported(String city) {
    return cityDistricts.containsKey(city);
  }

  static bool isDistrictSupported(String district) {
    return districtWards.containsKey(district);
  }

  // Search functionality
  static List<String> searchCities(String query) {
    if (query.isEmpty) return getCities();
    return getCities()
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static List<String> searchDistricts(String city, String query) {
    final districts = getDistrictsByCity(city);
    if (query.isEmpty) return districts;
    return districts
        .where((district) => district.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static List<String> searchWards(String district, String query) {
    final wards = getWardsByDistrict(district);
    if (query.isEmpty) return wards;
    return wards
        .where((ward) => ward.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}