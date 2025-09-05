import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/router/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../add_bank_account/domain/brand_bank.dart';
import '../../add_credit_card/views/add_credit_card_view.dart';
import '../controllers/payment_account_controller.dart';
import '../domain/credit_card_model.dart';
import '../widgets/add_card_row.dart';
import '../widgets/bank_account_row.dart';
import '../widgets/wallet_item.dart';

class PaymentAccountView extends GetView<PaymentAccountController> {

  String getBankIconByName(String bankName) {
    final lowerName = bankName.toLowerCase();
    final bank = banks.firstWhere(
          (b) => lowerName.contains(b['name']!.toLowerCase()),
      orElse: () => {'icon': Assets.images.icVietcom.path}, // fallback
    );
    return bank['icon']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          'Phương thức thanh toán',
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCardSection(
              title: LocaleKeys.credit_debit_account.trans(),
              child: Column(
                children: [
                  // 👉 Danh sách thẻ đã lưu
                  Obx(() {
                    if (controller.cards.isEmpty) {
                      return const SizedBox(); // không hiển thị gì nếu chưa có thẻ
                    }
                    return Column(
                      children: controller.cards
                          .map((card) => _SavedCardItem(card: card))
                          .toList(),
                    );
                  }),

                  const Divider(height: 32),

                  // 👉 Nút thêm thẻ mới
                  GestureDetector(
                  onTap:()=> Get.toNamed(Routes.addCreditCard),
                    child: AddCardRow(
                      label: LocaleKeys.add_new_card.trans(),
                      icons: [
                        Assets.images.icVisa.path,
                        Assets.images.icMastercard.path,
                        Assets.images.icJcb.path,
                        Assets.images.icAmericanexpress.path,
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _buildCardSection(
              title: LocaleKeys.bank_account.trans(),
              child: Obx(
                    () => Column(
                  children: [
                    for (int i = 0; i < controller.bankAccounts.length; i++) ...[
                      BankAccountRow(
                        iconPath: getBankIconByName(controller.bankAccounts[i].bankName),
                        bankName: controller.bankAccounts[i].bankName,
                        accountNumber:
                        "*${controller.bankAccounts[i].accountNumber.substring(controller.bankAccounts[i].accountNumber.length - 4)}",
                      ),
                      if (i != controller.bankAccounts.length - 1)
                        const SizedBox(height: 12), // 👈 Khoảng cách giữa các item
                    ],
                    const Divider(height: 32),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.selectBank),
                      child: AddCardRow(
                        label: LocaleKeys.add_bank_account.trans(),
                        icons: [
                          Assets.images.icVietcom.path,
                          Assets.images.icTechcombank.path,
                          Assets.images.ic21.path,
                        ],
                        iconSize: 20,
                      ),
                    ),
                  ],
                ),
              ),

            ),

            const SizedBox(height: 16),
            _buildCardSection(
              title: LocaleKeys.e_wallet.trans(),
              child: Column(
                children: [
                  WalletItem(
                    name: "Momo",
                    iconPath: Assets.images.icMomo.path,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(LocaleKeys.default1.trans(), style: AppTypography.s12.bold),
                    ),
                  ),
                   Divider(),
                  WalletItem(
                    name: "ZaloPay",
                    iconPath: Assets.images.logoZalo.path,
                    trailing: Text(LocaleKeys.not_linked.trans(), style: AppTypography.s14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppTypography.s16.regular.withColor(AppColors.neutral01),
            ),
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }
}
class _SavedCardItem extends StatelessWidget {
  final CreditCardModel card;

  const _SavedCardItem({required this.card});

  @override
  Widget build(BuildContext context) {
    final last4 = card.cardNumber.length >= 4
        ? card.cardNumber.substring(card.cardNumber.length - 4)
        : card.cardNumber;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        Assets.images.icVisa.path, // TODO: tự động chọn icon nếu cần
        height: 28,
      ),
      title: Text(card.cardHolder, style: AppTypography.s16),
      subtitle: Text("**** $last4", style: AppTypography.s14),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
    );
  }
}
