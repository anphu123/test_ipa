import 'dart:io';
import 'package:get/get.dart';
import '../views/identity_confirmation_view.dart';
import '../widgets/custom_camera_view.dart';

class UserIdentificationController extends GetxController {
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);
  Rx<File?> faceImage = Rx<File?>(null);
  RxInt currentTabIndex = 0.obs;

  Future<void> pickFrontCardImage() async {
    await Get.to(
      () => CustomCameraView(
        title: "Chụp mặt trước CCCD",
        onImageCaptured: (File image) {
          frontImage.value = image;
        },
      ),
    );
  }

  Future<void> pickBackCardImage() async {
    await Get.to(
      () => CustomCameraView(
        title: "Chụp mặt sau CCCD",
        onImageCaptured: (File image) {
          backImage.value = image;
        },
      ),
    );
  }

  Future<void> captureFaceImage() async {
    await Get.to(
      () => CustomCameraView(
        title: "Chụp ảnh khuôn mặt",
        onImageCaptured: (File image) {
          faceImage.value = image;
        },
      ),
    );
  }

  void onContinue() {
    if (frontImage.value == null ||
        backImage.value == null ||
        faceImage.value == null) {
      Get.snackbar('Thiếu thông tin', 'Vui lòng hoàn thành cả 3 bước xác minh');
      return;
    }

    // Tiếp tục xử lý xác minh
    Get.to(IdentityConfirmationView());
  }
}
