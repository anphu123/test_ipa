import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/block_list/controllers/block_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/blocked_user_model.dart';

class BlockListView extends GetView<BlockListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.block_list.trans(),

          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.blockedUsers.isEmpty) {
          return Center(child: Text(LocaleKeys.no_blocked_users.trans(),));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: _buildBlockedUserSection(controller.blockedUsers),
        );
      }),
    );
  }

  Widget _buildBlockedUserSection(List<BlockedUserModel> users) {
    return Container(
      // padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: List.generate(users.length, (index) {
          final user = users[index];
          final isLast = index == users.length - 1;

          return Column(
            children: [
              _BlockedUserTile(user: user),
              if (!isLast)
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  color:
                      AppColors
                          .neutral07, // hoặc AppColors.neutral06 nếu bạn có
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _BlockedUserTile extends StatelessWidget {
  final BlockedUserModel user;

  _BlockedUserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BlockListController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.white,
            backgroundImage:
                user.avatarUrl.isNotEmpty ? NetworkImage(user.avatarUrl) : null,
            radius: 20,
            child:
                user.avatarUrl.isEmpty
                    ? Image.asset(Assets.images.bear1.path)
                    : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              user.username,
              style: AppTypography.s14.regular.withColor(AppColors.neutral01),
            ),
          ),
          GestureDetector(
            onTap: () => _showUnblockDialog(context, controller, user),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary01),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                LocaleKeys.unblock.trans(),

                style: TextStyle(
                  color: AppColors.primary01,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUnblockDialog(
    BuildContext context,
    BlockListController controller,
    BlockedUserModel user,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.notification.trans(),

                    style: AppTypography.s20.bold.withColor(
                      AppColors.neutral01,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    LocaleKeys.confirm_unblock.trans() +  "${user.username}" + LocaleKeys.from_block_list.trans(),
                    textAlign: TextAlign.center,
                    style: AppTypography.s12.regular.withColor(
                      AppColors.neutral03,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.neutral04),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            LocaleKeys.cancel.trans(),
                            style: AppTypography.s16.regular.withColor(
                              AppColors.neutral01,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.unblockUser(user.id);
                            Navigator.of(context).pop(); // đóng dialog xác nhận

                            // Hiển thị dialog thành công trong 2s
                            Get.dialog(
                              buildSuccessDialog(user.username),
                              barrierDismissible: false,
                            );

                            Future.delayed(const Duration(seconds: 2), () {
                              if (Get.isDialogOpen == true) {
                                Get.back(); // đóng dialog thành công
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary01,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.agree.trans(),

                            style: AppTypography.s16.regular.withColor(
                              AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget buildSuccessDialog(String username) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: AppColors.AS01, size: 48),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.unblock_success.trans(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
