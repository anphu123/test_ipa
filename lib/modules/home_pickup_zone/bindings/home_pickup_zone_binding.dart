import 'package:get/get.dart';
import '../controllers/home_pickup_zone_controller.dart';

class HomePickupZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePickupZoneController>(
          () => HomePickupZoneController(),
    );
  }
}