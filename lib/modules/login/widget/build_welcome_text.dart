import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/assets/locale_keys.g.dart';

Widget buildWelcomeText() {
  return Column(
    children: [
      Text(
        LocaleKeys.login.trans(),
       // style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
        style: AppTypography.s22.bold,
        textAlign: TextAlign.center,
      ),
      // SizedBox(height: 8.h),
      // Text(
      //   LocaleKeys.pls_sign_in_continue.trans(),
      //   style: TextStyle(fontSize: 14.sp, color: Colors.grey),
      //   textAlign: TextAlign.center,
      // ),
    ],
  );
}
