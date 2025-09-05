import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../domain/chat_message_model.dart';

class SupportChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final ScrollController scrollController = ScrollController();

  final List<String> suggestions = [
    'Thời hạn thanh toán đơn hàng là bao lâu?',
    'Tra cứu đơn hàng',
    'Làm sao để biết sản phẩm có quà tặng kèm?',
    'Cách kiểm tra chất lượng sản phẩm?',
    'Sản phẩm được gửi đi bằng dịch vụ vận chuyển nào?',
  ];

  @override
  void onInit() {
    super.onInit();
    final String? initialMessage = Get.arguments as String?;
    initWithMessage(initialMessage);
  }

  void initWithMessage(String? msg) {
    if (msg != null && msg.trim().isNotEmpty) {
      sendMessage(msg.trim());
    }
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(ChatMessage(text: text, sender: MessageSender.user));
    autoReply(text);
  }

  void autoReply(String userMessage) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final reply = _getAutoReply(userMessage);
    messages.add(ChatMessage(text: reply, sender: MessageSender.bot));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getAutoReply(String msg) {
    msg = msg.toLowerCase();
    if (msg.contains('thanh toán'))
      return 'Thời hạn thanh toán là 3 ngày sau khi đặt hàng.';
    if (msg.contains('tra cứu'))
      return 'Bạn có thể tra cứu đơn hàng tại trang "Đơn hàng của tôi".';
    if (msg.contains('quà tặng'))
      return 'Sản phẩm có quà tặng sẽ được ghi rõ trong chi tiết sản phẩm.';
    if (msg.contains('chất lượng'))
      return 'Chúng tôi cam kết sản phẩm chính hãng và có bảo hành.';
    if (msg.contains('vận chuyển'))
      return 'Chúng tôi sử dụng Giao Hàng Nhanh (GHN) và ViettelPost.';
    return 'Cảm ơn bạn đã liên hệ, chúng tôi sẽ hỗ trợ sớm nhất!';
  }
}
