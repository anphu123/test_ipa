import 'package:dio/dio.dart';

class ApiLoginService {
  static final Dio _dio = Dio();

  static Future<Response> sendOtp(String phone) async {
    return await _dio.post(
      'https://bendeptrai.com/api/v1/sms/send',
      data: {
        "key": "ZHMM",
        "mobile": phone,
      },
    );
  }

  static Future<Response> verifyOtp(String phone, String code) async {
    return await _dio.post(
      'https://bendeptrai.com/api/v1/sms/verify',
      data: {
        "phone": phone,
        "code": code,
      },
    );
  }
}
