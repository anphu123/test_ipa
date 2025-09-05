import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/register/controllers/register_controller.dart';
import 'package:fido_box_demo01/modules/register/widgets/build_password_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/build_confirm_password_field.dart';
import '../widgets/build_email_field.dart';
import '../widgets/build_name_field.dart';
import '../widgets/build_register_button.dart';
import '../../login/widget/confirm_read.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.register_screen.trans()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            buildNameField(),
            SizedBox(height: 16.h),
            buildEmailField(),
            SizedBox(height: 16.h),
            buildPasswordFieldR(),
            SizedBox(height: 16.h),
            buildConfirmPasswordField(),
            SizedBox(height: 24.h),
            confirmRead(),
            SizedBox(height: 16.h),
            buildRegisterButton(),
          ],
        ),
      ),
    );
  }
}
