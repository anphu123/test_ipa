// import 'package:dio/dio.dart';
//
// class ApiService {
//   static const String supabaseUrl = 'https://xvpmhhrsvbpgchjjajrg.supabase.co';
//   static const String supabaseKey =
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cG1oaHJzdmJwZ2NoamphanJnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg5MTYxNDIsImV4cCI6MjA2NDQ5MjE0Mn0.DKXd56qjvYeW465JhuOVrK5kT5fB9CHYz7ylYaq9Mm0'; // Đừng dùng service-role ở client
//
//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: supabaseUrl,
//       headers: {'apikey': supabaseKey, 'Authorization': 'Bearer $supabaseKey'},
//     ),
//   );
//
//   Future<List<Map<String, dynamic>>> fetchCategories() async {
//     final response = await dio.get('/categories');
//     return List<Map<String, dynamic>>.from(response.data);
//   }
//
//   Future<List<Map<String, dynamic>>> fetchSubCategories() async {
//     final response = await dio.get('/sub_categories');
//     return List<Map<String, dynamic>>.from(response.data);
//   }
//
//   Future<List<Map<String, dynamic>>> fetchProducts() async {
//     final response = await dio.get('/products');
//     return List<Map<String, dynamic>>.from(response.data);
//   }
// }
