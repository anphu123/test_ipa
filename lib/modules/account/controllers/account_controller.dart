import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  final avatarImage = Rx<File?>(null);
  final username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    print('AccountController: onInit called');
    _loadUserData();
    refreshAvatar();
  }

  Future<void> refreshAvatar() async {
    print('AccountController: refreshAvatar started');
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('user_avatar');
    print('AccountController: avatar path from prefs: $path');
    
    if (path != null && File(path).existsSync()) {
      avatarImage.value = File(path);
      print('AccountController: avatar loaded successfully from: $path');
    } else {
      print('AccountController: no valid avatar found, path: $path');
    }
  }

  Future<void> updateNickname(String newName) async {
    print('AccountController: updating nickname to: $newName');
    username.value = newName;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', newName);
    print('AccountController: nickname saved to SharedPreferences');
  }

  Future<void> _loadUserData() async {
    print('AccountController: loading user data');
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('nickname') ?? 'XiaoYu';
    print('AccountController: loaded username: ${username.value}');

    final path = prefs.getString('user_avatar');
    if (path != null && File(path).existsSync()) {
      avatarImage.value = File(path);
      print('AccountController: loaded avatar from: $path');
    } else {
      avatarImage.value = null;
      print('AccountController: no avatar found, set to null');
    }
  }

  Future<void> updateAvatar(File newAvatar) async {
    print('AccountController: updating avatar to: ${newAvatar.path}');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_avatar', newAvatar.path);
    avatarImage.value = newAvatar;
    print('AccountController: avatar updated and saved');
  }

  Future<void> updateUsername(String newName) async {
    print('AccountController: updating username to: $newName');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', newName);
    username.value = newName;
    print('AccountController: username updated and saved');
  }
}