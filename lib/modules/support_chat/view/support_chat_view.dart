import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../controllers/support_chat_controller.dart';
import '../domain/chat_message_model.dart';
import '../widgets/build_message.dart';
import '../widgets/build_welcome_card.dart';

class SupportChatView extends GetView<SupportChatController> {
  final TextEditingController textController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final String? initialMessage = Get.arguments;

    // Gửi tin nhắn khởi tạo nếu có
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialMessage != null &&
          initialMessage.trim().isNotEmpty &&
          controller.messages.isEmpty) {
        controller.initWithMessage(initialMessage);
      }
    });

    // Tự động scroll đến cuối khi có tin nhắn mới
    ever(controller.messages, (_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (listScrollController.hasClients) {
          listScrollController.animateTo(
            listScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Nội dung và danh sách tin nhắn
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
               //   elevation: 0,
                  backgroundColor: innerBoxIsScrolled
                      ? AppColors.primary01   // màu khi scroll (pinned)
                      : AppColors.white,      // màu ban đầu (chưa scroll)
                  leading: const BackButton(),
                  title: Text(
                    'CSKH',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: innerBoxIsScrolled ? Colors.white : Colors.black,
                    ),
                  ),
                  centerTitle: false,
                ),



              ],
              body: Obx(() {
                final hasMessages = controller.messages.isNotEmpty;

                return ListView.builder(
                  //primary: true,
                  controller: listScrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  itemCount: hasMessages ? controller.messages.length + 1 : 1,
                  itemBuilder: (_, index) {
                    if (index == 0) return WelcomeCard();

                    final msg = controller.messages[index - 1];
                    final isLastMessage = index == controller.messages.length;
                    final isNew = isLastMessage && msg.sender != MessageSender.user;

                    return buildMessage(msg, isNew: isNew);
                  },
                );
              }),
            ),
          ),

          // Input soạn tin nhắn
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'Nhập tin nhắn',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: AppColors.neutral04),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: AppColors.neutral04),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: AppColors.primary01, width: 1.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    final text = textController.text.trim();
                    if (text.isNotEmpty) {
                      controller.sendMessage(text);
                      textController.clear();
                    }
                  },
                  child: Image.asset(
                    Assets.images.icSend.path,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
