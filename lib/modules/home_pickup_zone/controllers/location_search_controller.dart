import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../domain/place_prediction.dart';

class LocationSearchController extends GetxController {
  final searchText = ''.obs;
  final isLoading = false.obs;
  final predictions = <PlacePrediction>[].obs;
  final Dio _dio = Dio();

  final String _apiKey = 'YOUR_API_KEY';

  void onSearchChanged(String value) {
    searchText.value = value;
    if (value.trim().length >= 3) {
      _performSearch(value.trim());
    } else {
      predictions.clear();
    }
  }

  Future<void> _performSearch(String input) async {
    isLoading.value = true;
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': input,
          'key': _apiKey,
          'language': 'vi',
          'components': 'country:vn',
        },
      );

      final data = response.data;
      if (data['status'] == 'OK') {
        predictions.assignAll(
          (data['predictions'] as List)
              .map((e) => PlacePrediction.fromJson(e))
              .toList(),
        );
      } else {
        predictions.clear();
      }
    } catch (e) {
      predictions.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void selectPrediction(PlacePrediction prediction) {
    Get.back(result: prediction);
  }
}
