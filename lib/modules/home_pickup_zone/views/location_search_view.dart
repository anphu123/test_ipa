import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_search_controller.dart';

class LocationSearchView extends StatelessWidget {
  final controller = Get.put(LocationSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tìm địa điểm')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: controller.onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Nhập địa chỉ (VD: 19 Tân Cảng)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }

              if (controller.predictions.isEmpty) {
                return const Text('Không có kết quả');
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.predictions.length,
                  itemBuilder: (_, index) {
                    final item = controller.predictions[index];
                    return ListTile(
                      title: Text(item.description),
                      onTap: () => controller.selectPrediction(item),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Powered by Google',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
