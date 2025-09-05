import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SmsNotificationController extends GetxController{
  // Define your sms_notification logic here
  final box = GetStorage();

  final isNotificationOn = false.obs;
  final isSoundOn = false.obs;
  final isOrderOn = false.obs;
  final isChatOn = false.obs;
  final isPromoOn = false.obs;

  @override
  void onInit() {
    super.onInit();

    isNotificationOn.value = box.read('isNotificationOn') ?? true;
    isSoundOn.value = box.read('isSoundOn') ?? true;
    isOrderOn.value = box.read('isOrderOn') ?? true;
    isChatOn.value = box.read('isChatOn') ?? true;
    isPromoOn.value = box.read('isPromoOn') ?? false;

    // Optional: listen changes and save
    isNotificationOn.listen((val) => box.write('isNotificationOn', val));
    isSoundOn.listen((val) => box.write('isSoundOn', val));
    isOrderOn.listen((val) => box.write('isOrderOn', val));
    isChatOn.listen((val) => box.write('isChatOn', val));
    isPromoOn.listen((val) => box.write('isPromoOn', val));
  }
}