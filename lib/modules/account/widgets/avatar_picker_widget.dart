import 'dart:io';
import 'package:fido_box_demo01/core/theme/app_colors.dart';
import 'package:fido_box_demo01/core/theme/app_typography.dart';
import 'package:fido_box_demo01/modules/account/controllers/account_controller.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/assets/assets.gen.dart';

class HeaderWithAvatar extends StatefulWidget {
  const HeaderWithAvatar({super.key});

  @override
  State<HeaderWithAvatar> createState() => _HeaderWithAvatarState();
}

class _HeaderWithAvatarState extends State<HeaderWithAvatar> {
  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    //   _loadAvatarFromPrefs();
  }

  //
  // Future<void> _loadAvatarFromPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final path = prefs.getString('user_avatar');
  //   if (path != null && File(path).existsSync()) {
  //     setState(() {
  //       _avatarImage = File(path);
  //     });
  //   }
  // }

  // Future<void> _pickImage(ImageSource source) async {
  //   final status = await _requestPermission(source);
  //
  //   if (!status) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Không có quyền truy cập ${source == ImageSource.camera ? "camera" : "thư viện"}'),
  //       ),
  //     );
  //     return;
  //   }
  //
  //   final XFile? pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     final appDir = await getApplicationDocumentsDirectory();
  //     final savedImage = await File(pickedFile.path)
  //         .copy('${appDir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.png');
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('user_avatar', savedImage.path);
  //
  //     setState(() {
  //       _avatarImage = savedImage;
  //     });
  //
  //     // Notify listeners or update state management solution if needed
  //     // For example, if using GetX:
  //     // Get.find<UserController>().updateAvatar(savedImage);
  //   }
  // }
  // Future<bool> _requestPermission(ImageSource source) async {
  //   final Permission permission = source == ImageSource.camera
  //       ? Permission.camera
  //       : (Platform.isAndroid ? Permission.storage : Permission.photos);
  //   return await permission.request().isGranted;
  // }
  //
  // void _showPickerOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
  //     ),
  //     builder: (ctx) => SafeArea(
  //       child: Padding(
  //         padding: EdgeInsets.all(16.w),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.camera_alt),
  //               title: const Text('Chụp ảnh'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickImage(ImageSource.camera);
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.photo_library),
  //               title: const Text('Chọn từ thư viện'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickImage(ImageSource.gallery);
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();
    return Container(
      padding: EdgeInsets.only(
        top: 40.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF69595), // Hồng nhạt phía trên
            Color(0xFFFF2F57), // Hồng đậm phía dưới
          ],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12), // hoặc dùng .r nếu dùng ScreenUtil
        ),
      ),


      child: Row(
        children: [
          Stack(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 28.r,
                  backgroundImage:
                      controller.avatarImage.value != null
                          ? FileImage(controller.avatarImage.value!)
                          : const NetworkImage(
                                'https://media.licdn.com/dms/image/v2/D5635AQHwcJvQ2RgOuQ/profile-framedphoto-shrink_200_200/profile-framedphoto-shrink_200_200/0/1712476452606?e=1751364000&v=beta&t=FPnpAlqSerp-w8OgKR2M_t8zAbXzIiFPv3xtpGsT5HY',
                              )
                              as ImageProvider,
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: Container(
              //     padding: EdgeInsets.all(4.r),
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Colors.white,
              //     ),
              //     child: Icon(Icons.edit, size: 14.sp, color: Colors.black),
              //   ),
              // ),
            ],
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  Get.find<AccountController>().username.value,
                  style: AppTypography.s16.bold.withColor(AppColors.white),

                ),
              ),

              // Text(
              //   "Điểm cacbon 0",
              //   style: TextStyle(fontSize: 12.sp, color: Colors.white70),
              // ),
            ],
          ),
          const Spacer(),
          InkWell(child: Image.asset(Assets.images.icScan.path)),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.addCreditCard),
            child: InkWell(child: Image.asset(Assets.images.icTinnhan.path)),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.setting),
            child: InkWell(child: Image.asset(Assets.images.icCaidat.path)),
          ),
        ],
      ),
    );
  }
}
