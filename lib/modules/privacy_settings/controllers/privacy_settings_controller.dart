import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PrivacySettingsController extends GetxController{
  final box = GetStorage();

  final isLocationAccessOn = false.obs;
  final isContactsAccessOn = false.obs;
  final isMicrophoneAccessOn = false.obs;
  final isPhotoLibraryAccessOn = false.obs;
  final isCameraAccessOn = false.obs;
  final isFollowListHidden = false.obs;
  final isContactInfoHidden = false.obs;

  @override
  void onInit() {
    super.onInit();

    isLocationAccessOn.value = box.read('isLocationAccessOn') ?? true;
    isContactsAccessOn.value = box.read('isContactsAccessOn') ?? true;
    isMicrophoneAccessOn.value = box.read('isMicrophoneAccessOn') ?? true;
    isPhotoLibraryAccessOn.value = box.read('isPhotoLibraryAccessOn') ?? true;
    isCameraAccessOn.value = box.read('isCameraAccessOn') ?? true;
    isFollowListHidden.value = box.read('isFollowListHidden') ?? false;
    isContactInfoHidden.value = box.read('isContactInfoHidden') ?? true;

    // Optional: listen changes and save
    isLocationAccessOn.listen((val) => box.write('isLocationAccessOn', val));
    isContactsAccessOn.listen((val) => box.write('isContactsAccessOn', val));
    isMicrophoneAccessOn.listen((val) => box.write('isMicrophoneAccessOn', val));
    isPhotoLibraryAccessOn.listen((val) => box.write('isPhotoLibraryAccessOn', val));
    isCameraAccessOn.listen((val) => box.write('isCameraAccessOn', val));
    isFollowListHidden.listen((val) => box.write('isFollowListHidden', val));
    isContactInfoHidden.listen((val) => box.write('isContactInfoHidden', val));
  }
}
