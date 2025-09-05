import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/dashboard_controller.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<DashBoardController>(
      DashBoardController(),
    );

    Get.put<HomeController>(
      HomeController(

      ),
    );

  //
  //   Get.put<ApprovalController>(
  //     ApprovalController(
  //       workflowRouteUsecase: Get.find(),
  //       preferenceManager: Get.find(),
  //       authService: Get.find(),
  //       businessTripUseCase: Get.find(),
  //       homeUseCase: Get.find(),
  //       listStoreUseCase: Get.find(),
  //     ),
  //   );
  //   // Get.put<ApprovalDashboardController>(
  //   //   ApprovalDashboardController(systemDataUseCase: Get.find(), businessTripUseCase: Get.find(), workflowRouteUsecase: Get.find()),
  //   // );
  //   Get.put<NotificationController>(
  //     NotificationController(
  //       notificationUsecase: Get.find(),
  //       authService: Get.find(),
  //       preferenceManager: Get.find(),
  //     ),
  //   );
  //   Get.put<AccountController>(
  //     AccountController(),
  //   );
  // }
}}
