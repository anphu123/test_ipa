import 'dart:io';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/account/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../../home/controllers/home_controller.dart';

class PersonalProfileController extends GetxController {
  RxString nickname = 'XiaoYu'.obs;
  Rx<File?> avatarImage = Rx<File?>(null);
  var gender = ''.obs;
  RxString introduction = ''.obs;
  Rxn<DateTime> birthDate = Rxn<DateTime>();
  final RxString detectedCity  = ''.obs; // Dữ liệu từ GPS
  final RxString area = ''.obs;             // Dữ liệu user chọn (có thể từ GPS hoặc thủ công)

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    loadGender();
    loadBirthDate();
    loadArea();
  }
  /// Load khu vực từ SharedPreferences
  Future<void> loadArea() async {
    final prefs = await SharedPreferences.getInstance();
    area.value = prefs.getString('area') ?? '';
  }

  /// Cập nhật khu vực do người dùng chọn
  Future<void> setArea(String newArea) async {
    area.value = newArea;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('area', newArea);
  }

  /// Yêu cầu quyền định vị và lấy tên thành phố (chỉ gán vào detectedCity)
  Future<String?> requestAndGetCityName({bool autoPop = false}) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        final city = placemarks.first.administrativeArea ?? '';
        detectedCity.value = city; // <-- KHÔNG gán vào area

        if (autoPop) {
          // Nếu autoPop = true thì cho rằng user chọn city này luôn
          await setArea(city);
          return city;
        }
      }
    } catch (e) {
      print("❌ Location Error: $e");
    }
    return null;
  }

  Future<void> loadBirthDate() async {
    final prefs = await SharedPreferences.getInstance();
    final birthDateString = prefs.getString('birth_date');
    if (birthDateString != null) {
      birthDate.value = DateTime.tryParse(birthDateString);
    }
  }

  Future<void> setBirthDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('birth_date', date.toIso8601String());
    birthDate.value = date;
  }

  Future<void> updateIntroduction(String newIntro) async {
    introduction.value = newIntro;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('introduction', newIntro);
  }
  Future<void> loadGender() async {
    final prefs = await SharedPreferences.getInstance();
    gender.value = prefs.getString('gender') ?? LocaleKeys.male.trans();
  }

  Future<void> setGender(String newGender) async {
    gender.value = newGender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', newGender);
  }

  /// Load dữ liệu người dùng từ bộ nhớ (nickname và ảnh đại diện)
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nickname.value = prefs.getString('nickname') ?? 'XiaoYu';

    final path = prefs.getString('user_avatar');
    if (path != null && File(path).existsSync()) {
      avatarImage.value = File(path);
    }
  }

  /// Lưu biệt danh mới
  Future<void> updateNickname(String newName) async {
    nickname.value = newName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', newName);
  }

  /// Chọn ảnh từ thư viện hoặc camera
  Future<void> pickAvatar(ImageSource source) async {
    final granted = await _requestPermission(source);
    if (!granted) {
      Get.snackbar(
        'Thông báo',
        'Không có quyền truy cập ${source == ImageSource.camera ? "camera" : "thư viện"}',
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.png';
    final savedImage = await File(
      pickedFile.path,
    ).copy('${appDir.path}/$fileName');

    avatarImage.value = savedImage;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_avatar', savedImage.path);
    if (Get.isRegistered<AccountController>()) {
      Get.find<AccountController>().refreshAvatar();
    }
  }

  /// Yêu cầu quyền camera/thư viện
  Future<bool> _requestPermission(ImageSource source) async {
    final Permission permission =
        source == ImageSource.camera
            ? Permission.camera
            : (Platform.isAndroid ? Permission.storage : Permission.photos);

    final status = await permission.request();
    return status.isGranted;
  }

  /// Lưu toàn bộ hồ sơ (ở đây chỉ có nickname + avatar)
  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname.value);
    if (avatarImage.value != null) {
      await prefs.setString('user_avatar', avatarImage.value!.path);
    }
    Get.back();
    Get.snackbar("Thành công", "Đã lưu hồ sơ cá nhân");
  }

  /// Mở dialog đổi tên (gọi từ view, tách UI)
  void changeNickname(BuildContext context) {
    final controller = TextEditingController(text: nickname.value);
    Get.dialog(
      AlertDialog(
        title: const Text("Đổi biệt danh"),
        content: TextField(
          controller: controller,
          maxLength: 13,
          decoration: const InputDecoration(hintText: "Nhập biệt danh mới"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Hủy")),
          ElevatedButton(
            onPressed: () {
              updateNickname(controller.text);
              Get.back();
            },
            child: const Text("Lưu"),
          ),
        ],
      ),
    );
  }

  /// Mở modal chọn ảnh đại diện (camera/gallery)
  void showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(LocaleKeys.take_photo.trans()),
                  onTap: () {
                    Get.back();
                    pickAvatar(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title:  Text(LocaleKeys.select_from_library.trans()),
                  onTap: () {
                    Get.back();
                    pickAvatar(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }
}
