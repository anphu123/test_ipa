import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/assets/locale_keys.g.dart';

class ManagePersonalScreen extends StatefulWidget {
  const ManagePersonalScreen({super.key});

  @override
  State<ManagePersonalScreen> createState() => _ManagePersonalScreenState();
}

class _ManagePersonalScreenState extends State<ManagePersonalScreen> {
  bool showAge = true;
  bool showLocation = true;
  bool showProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.manage_profile_page.trans()),
        centerTitle: true,
        backgroundColor: Colors.white,


      ),
      backgroundColor:AppColors.neutral08,
      body: Container(
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 👈 co lại theo nội dung
          children: [
            _buildSwitchTile(LocaleKeys.age.trans(), showAge, (value) {
              setState(() => showAge = value);
            }),
            _buildSwitchTile(LocaleKeys.location.trans(), showLocation, (value) {
              setState(() => showLocation = value);
            }),
            _buildSwitchTile(LocaleKeys.profile.trans(), showProfile, (value) {
              setState(() => showProfile = value);
            }),
          ],
        ),
      ),

    );
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16.sp)),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary01,
      ),
    );


  }
}
