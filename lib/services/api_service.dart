import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ApiService {
  static const String baseUrl =
      "https://67a589a4c0ac39787a1e95ca.mockapi.io/api/v1";

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  /// Kiểm tra user tồn tại theo username
  Future<bool> isUserExist(String username) async {
    try {
      final response = await _dio.get(
        '/user',
        queryParameters: {"username": username},
      );
      if (response.statusCode == 200) {
        final users = List<Map<String, dynamic>>.from(response.data);
        return users.any((u) => u['username'] == username);
      }
    } catch (e) {
      print("❌ Lỗi kiểm tra user tồn tại: $e");
    }
    return false;
  }

  /// Đăng nhập
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await _dio.get(
        '/user',
        queryParameters: {"username": username},
      );
      if (response.statusCode == 200) {
        final users = List<Map<String, dynamic>>.from(response.data);
        final user = users.firstWhere(
          (u) => u['username'] == username,
          orElse: () => {},
        );
        if (user.isNotEmpty && user['password'] == password) {
          return user;
        }
      }
    } catch (e) {
      print("❌ Lỗi đăng nhập: $e");
    }
    return null;
  }

  /// Đăng ký (check user tồn tại trước)
  Future<Map<String, dynamic>?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final exists = await isUserExist(name);
      if (exists) {
        print("⚠️ Username đã tồn tại");
        return null;
      }

      final response = await _dio.post(
        '/user',
        data: {"username": name, "email": email, "password": password},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      }
    } catch (e) {
      print("❌ Lỗi đăng ký: $e");
    }
    return null;
  }

  /// Đăng nhập bằng Google (giả định backend không có xác thực token)
  Future<Map<String, dynamic>?> loginWithGoogle(String idToken) async {
    try {
      // Giả lập lấy thông tin từ token (ở môi trường thật, bạn nên verify token qua backend)
      final googleSignIn = GoogleSignIn();
      final currentUser = await googleSignIn.signInSilently();
      if (currentUser == null) return null;

      final email = currentUser.email;
      final name = currentUser.displayName ?? email.split('@').first;

      // Kiểm tra xem user đã tồn tại chưa
      final response = await _dio.get(
        '/user',
        queryParameters: {"email": email},
      );
      final users = List<Map<String, dynamic>>.from(response.data ?? []);

      if (users.isNotEmpty) {
        return users.first; // user đã tồn tại => đăng nhập
      } else {
        // Chưa có => đăng ký mới
        final registerResponse = await _dio.post(
          '/user',
          data: {
            "username": name,
            "email": email,
            "password": "", // Không cần mật khẩu nếu đăng nhập bằng Google
          },
        );

        if (registerResponse.statusCode == 201 ||
            registerResponse.statusCode == 200) {
          return Map<String, dynamic>.from(registerResponse.data);
        }
      }
    } catch (e) {
      print("❌ Lỗi đăng nhập Google: $e");
    }
    return null;
  }
}
