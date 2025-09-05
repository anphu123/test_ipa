import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';
import '../../personal_profile/controllers/personal_profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.put(() => LoginController());
       Get.put(PersonalProfileController());
  }
}
