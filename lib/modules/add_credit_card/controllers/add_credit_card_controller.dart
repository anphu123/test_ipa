import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../payment_account/controllers/payment_account_controller.dart';
import '../../payment_account/domain/credit_card_model.dart';

class AddCreditCardController extends GetxController {
  final box = GetStorage();

  final cardHolder = ''.obs;
  final cardNumber = ''.obs;
  final expiryDate = ''.obs;
  final cvv = ''.obs;
  final address = ''.obs;
  final postalCode = ''.obs;

  final cards = <CreditCardModel>[].obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadCards();
  }

  void loadCards() {
    final data = box.read<List>('saved_cards') ?? [];
    cards.assignAll(
      data.map((e) => CreditCardModel.fromJson(Map<String, dynamic>.from(e))),
    );
  }

  void saveCard() {
    final newCard = CreditCardModel(
      cardHolder: cardHolder.value.trim(),
      cardNumber: cardNumber.value.trim(),
      expiryDate: expiryDate.value.trim(),
      cvv: cvv.value.trim(),
      address: address.value.trim(),
      postalCode: postalCode.value.trim(),
    );

    cards.add(newCard);
    box.write('saved_cards', cards.map((e) => e.toJson()).toList());

    // 🟢 Load lại danh sách thẻ ở màn chính
    final paymentController = Get.find<PaymentAccountController>();
    paymentController.loadCards();

    showSuccessDialog();// Đóng màn hình
  }
  void showSuccessDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              Text(
                'THÀNH CÔNG',
                style: AppTypography.s16.bold.withColor(AppColors.neutral01),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Bạn đã liên kết tài khoản thành công',
                style: AppTypography.s14.withColor(AppColors.neutral03),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    // Tự động đóng sau 3 giây
    Future.delayed(const Duration(seconds: 1), () {
      Get.back(); // Đóng dialog
      Get.back(); // Quay lại màn hình trước
    });
  }


}
