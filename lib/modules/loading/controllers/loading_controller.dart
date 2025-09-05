import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../router/app_page.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class LoadingController extends GetxController {
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 1), () {
      // final isLoggedIn = _storage.read<bool>('isLoggedIn') ?? false;
      //   Get.delete<DashBoardController>(force: true);

      // ✅ Dù là true hay false thì đều về dashboard
      // Dashboard sẽ tự xử lý UI theo login
      Get.offAllNamed(Routes.dashboard);
    });
  }
}
