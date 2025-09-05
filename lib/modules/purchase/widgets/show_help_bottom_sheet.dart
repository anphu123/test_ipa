import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/purchase_controller.dart';

void ShowHelpBottomSheet(BuildContext context) {
  final controller1 = Get.find<PurchaseController>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    // ),
    builder: (context) {

      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder:
            (_, controller) => Container(
          // Set background color
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),

          padding: EdgeInsets.all(16.w),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              Text(
                "Phản hồi ý kiến",
                style: AppTypography.s16.semibold.withColor(
                  AppColors.neutral01,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                "Bạn có vấn đề gì cần giải đáp?",
                style: AppTypography.s14.bold.withColor(
                  AppColors.neutral01,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.neutral08,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TextField(
                  maxLines: 5,
                  maxLength: 5000,
                  decoration: InputDecoration(
                    hintText:
                    "Càng điền chi tiết, vấn đề càng dễ dàng giải quyết",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              ImageUploadRow(images: controller1.uploadedImages),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Handle image upload
              //   },
              //   icon: Icon(Icons.camera_alt),
              //   label: Text("Ảnh sản phẩm"),
              // ),
              SizedBox(height: 8.h),
              Text(
                "Vui lòng tải lên hình ảnh chính xác để vấn đề được nhận hỗ trợ tốt nhất",
                style: AppTypography.s12.regular.withColor(Colors.grey),
              ),
              SizedBox(height: 16.h),
              Text("Mức độ hài lòng của bạn cho trải nghiệm này?"),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                      (index) => ElevatedButton(
                    onPressed: () {
                      // Handle satisfaction score
                    },
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  // Submit action
                  Navigator.pop(context);
                },
                child: Text("Gửi"),
              ),
            ],
          ),
        ),
      );
    },
  );
}
class ImageUploadRow extends StatelessWidget {
  final RxList<File> images;

  const ImageUploadRow({super.key, required this.images});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Chọn ảnh từ", style: AppTypography.s16.semibold),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption(
                  context,
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () async {
                    Navigator.pop(context); // Đóng sheet
                    final picked = await picker.pickImage(source: ImageSource.camera);
                    if (picked != null) {
                      images.add(File(picked.path));
                    }
                  },
                ),
                _buildOption(
                  context,
                  icon: Icons.photo_library,
                  label: "Thư viện",
                  onTap: () async {
                    Navigator.pop(context); // Đóng sheet
                    final picked = await picker.pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      images.add(File(picked.path));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.neutral08,
            child: Icon(icon, size: 28.w, color: AppColors.neutral01),
          ),
          SizedBox(height: 8.h),
          Text(label, style: AppTypography.s12.medium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...images.map(
                (file) => Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 100.w,
              height: 110.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.neutral08,
                image: DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _pickImage(context),
            child: Container(
              width: 100.w,
              height: 110.w,
              padding: EdgeInsets.all(1.w),
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: AppColors.neutral08,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.icTudangban.path,
                    width: 32.w,
                    height: 32.w,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Ảnh sản phẩm",
                    style: AppTypography.s12.medium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
