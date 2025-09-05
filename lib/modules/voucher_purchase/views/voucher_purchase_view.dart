// lib/modules/voucher_purchase/views/voucher_purchase_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/voucher_purchase_controller.dart';
import '../widgets/hub_coupon/show_voucher_dialog.dart';
import '../widgets/hub_coupon/voucher_center_view.dart';
import '../widgets/hub_coupon/voucher_purchase_bottom_nav.dart';
import '../widgets/voucher_wallet/voucher_wallet.dart';

class VoucherPurchaseView extends GetView<VoucherPurchaseController> {
  const VoucherPurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
          VoucherCongratDialog.show(context);
    });
    return Scaffold(
      //appBar: AppBar(title: const Text('Voucher Purchase')),
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
             VoucherCenterView(),
            //Center(child: Text('Ví Voucher Tab Content')),
            VoucherWalletView(),
          ],
        );
      }),
      bottomNavigationBar: VoucherPurchaseBottomNav(
        currentIndex: controller.currentIndex,
        onTap: controller.onTabChanged,
      ),
    );
  }
}
