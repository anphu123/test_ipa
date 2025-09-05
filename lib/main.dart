import 'package:easy_localization/easy_localization.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

 // ✅ Thiết lập màu thanh trạng thái (status bar)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Màu nền status bar
    statusBarIconBrightness: Brightness.dark, // Màu icon (đen sáng)
    statusBarBrightness: Brightness.light, // iOS
  ));

  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initService();
  configLoading();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('vi'), Locale('zh')],
      fallbackLocale: const Locale('en'),
     // startLocale: EasyLocalization.deviceLocale,
      child: const MyApp(),

    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ✅ Sử dụng ScreenUtilInit
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {


        return GetMaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.nunitoSansTextTheme(), // ✅ dùng Google Fonts ở đây
            // nếu muốn áp dụng fontFamily cho toàn bộ widget không chỉ text
            fontFamily: GoogleFonts.nunitoSans().fontFamily,
          ),
          getPages: AppPages.pages,
          initialRoute: AppPages.initPage,
          initialBinding: InitialBinding(),
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          builder: EasyLoading.init(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child!,
              );
            },
          ),
        );

      },
    );
  }
}

Future<void> initService() async {
  // Khởi tạo SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000) // Thời gian hiển thị
    ..indicatorType =
        EasyLoadingIndicatorType
            .fadingCircle // Loại đươn tròn
    ..loadingStyle =
        EasyLoadingStyle
            .dark // Kiểu loading
    ..indicatorSize =
    45.0 // Kích thước đơn tròn
    ..radius =
    10.0 // Bán kính đơn tròn
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.5)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}