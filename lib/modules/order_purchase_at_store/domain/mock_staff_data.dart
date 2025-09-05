import 'staff_model.dart';

class MockStaffData {
  static final List<StaffModel> mockStaffs = [
    // Staff 1 - Alice (High performer)
    StaffModel(
      id: 'STAFF-001',
      name: 'Alice',
      phoneNumber: '+84901234567',
      completedOrders: '16493',
      rating: '98',
      position: 'Chuyên gia thu mua',
      experience: '3 năm',
      specialty: 'Điện thoại, Laptop, Máy tính bảng',
      avatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150',
      isVerified: true,
      storeId: '1',
      workingHours: '8:00 - 18:00',
      languages: ['Tiếng Việt', 'English'],
      averageRating: 4.9,
      totalReviews: 2847,
    ),

    // Staff 2 - Bob Nguyễn (Experienced)
    StaffModel(
      id: 'STAFF-002',
      name: 'Bob Nguyễn',
      phoneNumber: '+84912345678',
      completedOrders: '8750',
      rating: '96',
      position: 'Chuyên gia thu mua',
      experience: '2 năm',
      specialty: 'Laptop, Máy ảnh, Thiết bị số',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      isVerified: true,
      storeId: '2',
      workingHours: '9:00 - 17:00',
      languages: ['Tiếng Việt'],
      averageRating: 4.8,
      totalReviews: 1654,
    ),

    // Staff 3 - Charlie Trần (New but promising)
    StaffModel(
      id: 'STAFF-003',
      name: 'Charlie Trần',
      phoneNumber: '+84923456789',
      completedOrders: '1250',
      rating: '94',
      position: 'Chuyên gia thu mua',
      experience: '6 tháng',
      specialty: 'Máy tính bảng, Đồng hồ thông minh',
      avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
      isVerified: true,
      storeId: '3',
      workingHours: '8:30 - 17:30',
      languages: ['Tiếng Việt', 'English', '中文'],
      averageRating: 4.7,
      totalReviews: 423,
    ),

    // Staff 4 - Diana Lê (Senior expert)
    StaffModel(
      id: 'STAFF-004',
      name: 'Diana Lê',
      phoneNumber: '+84934567890',
      completedOrders: '22150',
      rating: '99',
      position: 'Chuyên gia cấp cao',
      experience: '5 năm',
      specialty: 'Tất cả thiết bị điện tử, Hàng xa xỉ',
      avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
      isVerified: true,
      storeId: '1',
      workingHours: '7:00 - 19:00',
      languages: ['Tiếng Việt', 'English', 'Français'],
      averageRating: 4.95,
      totalReviews: 3892,
    ),

    // Staff 5 - Eric Võ (Specialist)
    StaffModel(
      id: 'STAFF-005',
      name: 'Eric Võ',
      phoneNumber: '+84945678901',
      completedOrders: '5680',
      rating: '97',
      position: 'Chuyên gia thu mua',
      experience: '1.5 năm',
      specialty: 'Gaming, Console, Phụ kiện',
      avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      isVerified: true,
      storeId: '4',
      workingHours: '10:00 - 20:00',
      languages: ['Tiếng Việt', 'English'],
      averageRating: 4.85,
      totalReviews: 987,
    ),

    // Staff 6 - Fiona Phạm (Weekend specialist)
    StaffModel(
      id: 'STAFF-006',
      name: 'Fiona Phạm',
      phoneNumber: '+84956789012',
      completedOrders: '3420',
      rating: '95',
      position: 'Chuyên gia thu mua',
      experience: '1 năm',
      specialty: 'Điện thoại, Phụ kiện thời trang',
      avatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
      isVerified: true,
      storeId: '5',
      workingHours: '12:00 - 22:00',
      languages: ['Tiếng Việt'],
      averageRating: 4.75,
      totalReviews: 612,
    ),
  ];

  // Get staff by ID
  static StaffModel? getStaffById(String id) {
    try {
      return mockStaffs.firstWhere((staff) => staff.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get staff by store ID
  static List<StaffModel> getStaffByStoreId(String storeId) {
    return mockStaffs.where((staff) => staff.storeId == storeId).toList();
  }

  // Get random staff
  static StaffModel getRandomStaff() {
    mockStaffs.shuffle();
    return mockStaffs.first;
  }

  // Get top rated staff
  static List<StaffModel> getTopRatedStaff({int limit = 3}) {
    final sortedStaff = List<StaffModel>.from(mockStaffs);
    sortedStaff.sort((a, b) => b.averageRating.compareTo(a.averageRating));
    return sortedStaff.take(limit).toList();
  }

  // Get staff by experience level
  static List<StaffModel> getStaffByExperience(String level) {
    return mockStaffs.where((staff) => staff.experienceLevel == level).toList();
  }

  // Get available staff (mock availability)
  static List<StaffModel> getAvailableStaff() {
    // Mock: return staff who are currently "available"
    return mockStaffs.where((staff) {
      final now = DateTime.now();
      final hour = now.hour;
      
      // Simple availability check based on working hours
      if (staff.workingHours.contains('8:00')) return hour >= 8 && hour <= 18;
      if (staff.workingHours.contains('9:00')) return hour >= 9 && hour <= 17;
      if (staff.workingHours.contains('10:00')) return hour >= 10 && hour <= 20;
      if (staff.workingHours.contains('12:00')) return hour >= 12 && hour <= 22;
      
      return true; // Default available
    }).toList();
  }

  // Get staff statistics
  static Map<String, dynamic> getStaffStatistics() {
    final totalStaff = mockStaffs.length;
    final totalOrders = mockStaffs.fold<int>(
      0, 
      (sum, staff) => sum + int.parse(staff.completedOrders.replaceAll(',', '')),
    );
    final averageRating = mockStaffs.fold<double>(
      0, 
      (sum, staff) => sum + staff.averageRating,
    ) / totalStaff;

    return {
      'totalStaff': totalStaff,
      'totalOrders': totalOrders,
      'averageRating': averageRating.toStringAsFixed(2),
      'highRatedStaff': mockStaffs.where((s) => s.isHighRated).length,
      'verifiedStaff': mockStaffs.where((s) => s.isVerified).length,
    };
  }

  // Search staff by name or specialty
  static List<StaffModel> searchStaff(String query) {
    final lowerQuery = query.toLowerCase();
    return mockStaffs.where((staff) {
      return staff.name.toLowerCase().contains(lowerQuery) ||
             staff.specialty.toLowerCase().contains(lowerQuery) ||
             staff.position.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
