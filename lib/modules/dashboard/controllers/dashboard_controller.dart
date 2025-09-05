import 'package:fido_box_demo01/modules/account/controllers/account_controller.dart';
import 'package:fido_box_demo01/modules/support_chat/controllers/support_chat_controller.dart';
import 'package:fido_box_demo01/modules/support_chat/view/support_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Open_market/controllers/open_market_controller.dart';
import '../../Open_market/views/open_market_view.dart';
import '../../account/views/account_view.dart';
import '../../favourite/controllers/favourite_controller.dart';
import '../../favourite/views/favourite_view.dart';
import '../../home/views/home_view.dart';
import '../../mail_box/controllers/mail_box_controller.dart';
import '../../mail_box/views/mail_box_view.dart';

class DashBoardController extends GetxController {
  final selectedIndex = 0.obs;
  final isLoggedIn = false.obs;

  late final PageController pageController;
  final GetStorage _storage = GetStorage();

  final List<Widget> pages = [
    const HomeView(),
    GetBuilder<OpenMarketController>(
      init: OpenMarketController(),
      builder: (_) => OpenMarketView(),
    ),
    // GetBuilder<FavouriteController>(
    //   init: FavouriteController(),
    //   builder: (_) => FavouriteView(),
    // ),
    GetBuilder<MailBoxController>(
      init: MailBoxController(),
      builder: (_) => MailBoxView(),
    ),
    GetBuilder<AccountController>(
      init: AccountController(),
      builder: (_) => AccountScreen(),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    print('DashBoardController: onInit called');
    print('DashBoardController: initializing PageController with index: ${selectedIndex.value}');
    pageController = PageController(initialPage: selectedIndex.value);
    print('DashBoardController: PageController initialized');
    _checkLoginStatus(); // Gọi sớm để cập nhật isLoggedIn
  }

  @override
  void onClose() {
    print('DashBoardController: onClose called');
    pageController.dispose();
    print('DashBoardController: PageController disposed');
    super.onClose();
  }

  void onTabSelected(int index) {
    print('DashBoardController: tab selected - changing from ${selectedIndex.value} to $index');
    selectedIndex.value = index;
    pageController.jumpToPage(index);
    print('DashBoardController: jumped to page $index');
  }

  // UI config
  final double tabBarHeight = 80.0;
  final double iconSize = 30.0;
  final double labelFontSize = 14.0;

  TextStyle get centeredTabTextStyle => TextStyle(
    fontSize: labelFontSize,
    fontWeight: FontWeight.w500,
  );

  void _checkLoginStatus() {
    print('DashBoardController: checking login status');
    final loggedIn = _storage.read<bool>('isLoggedIn') ?? false;
    final loginTimeStr = _storage.read<String>('loginTime');
    
    print('DashBoardController: isLoggedIn from storage: $loggedIn');
    print('DashBoardController: loginTime from storage: $loginTimeStr');

    if (!loggedIn || loginTimeStr == null) {
      print('DashBoardController: user not logged in or no login time found');
      _redirectToLogin();
      return;
    }

    final loginTime = DateTime.tryParse(loginTimeStr);
    if (loginTime == null) {
      print('DashBoardController: invalid login time format: $loginTimeStr');
      _logoutExpiredSession();
    } else {
      final hoursDiff = DateTime.now().difference(loginTime).inHours;
      print('DashBoardController: hours since login: $hoursDiff');
      
      if (hoursDiff >= 24) {
        print('DashBoardController: login session expired (>= 24 hours)');
        _logoutExpiredSession();
      } else {
        print('DashBoardController: login session valid, setting isLoggedIn to true');
        isLoggedIn.value = true;
      }
    }
  }

  void _redirectToLogin() {
    print('DashBoardController: redirecting to login');
    isLoggedIn.value = false;
    print('DashBoardController: isLoggedIn set to false');
    // Future.delayed(Duration.zero, () => Get.offAllNamed(Routes.LOGIN));
    print('DashBoardController: login redirect commented out');
  }

  void _logoutExpiredSession() {
    print('DashBoardController: logging out expired session');
    _storage.remove('isLoggedIn');
    _storage.remove('user');
    _storage.remove('loginTime');
    print('DashBoardController: cleared login data from storage');
    _redirectToLogin();
  }
}