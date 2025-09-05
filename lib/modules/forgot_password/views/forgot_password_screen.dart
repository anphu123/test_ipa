import 'package:fido_box_demo01/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController>{
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Center(
        child: Text(
          "Forgot Password Screen",
   //       style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}