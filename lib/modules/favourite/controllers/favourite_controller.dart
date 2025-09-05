import 'package:get/get.dart';

class FavouriteController extends GetxController {
  final currentTab = 0.obs;

  void changeTab(int index) {
    currentTab.value = index;
  }
  // Add your controller logic here
  // For example, you can define variables, methods, and state management logic
}