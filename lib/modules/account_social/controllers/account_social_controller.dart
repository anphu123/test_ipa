import 'package:get/get.dart';

class AccountSocialController extends GetxController {
  var isGoogleLinked = true.obs;
  var isFacebookLinked = false.obs;
  var isZaloLinked = false.obs;

  void linkAccount(String provider) {
    switch (provider) {
      case 'Google':
        isGoogleLinked.value = true;
        break;
      case 'Facebook':
        isFacebookLinked.value = true;
        break;
      case 'Zalo':
        isZaloLinked.value = true;
        break;
    }
  }

  void unlinkAccount(String provider) {
    switch (provider) {
      case 'Google':
        isGoogleLinked.value = false;
        break;
      case 'Facebook':
        isFacebookLinked.value = false;
        break;
      case 'Zalo':
        isZaloLinked.value = false;
        break;
    }
  }
}
