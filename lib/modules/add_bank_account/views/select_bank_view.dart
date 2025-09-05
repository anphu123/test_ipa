import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/brand_bank.dart';
import 'add_bank_account_view.dart';

class SelectBankView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title:  Text('Thêm ngân hàng liên kết',style: AppTypography.s20.medium.withColor(AppColors.neutral01)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16), // ✅ Bo góc khung ngoài
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: banks.map((bank) {
              return GestureDetector(
                onTap: () => Get.to(() => AddBankAccountView(bankName: bank['name']!)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4 - 24,
                  padding: const EdgeInsets.symmetric(vertical: 8),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(bank['icon']!, width: 40, height: 40),
                      const SizedBox(height: 4),
                      Text(
                        bank['name']!,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),

    );
  }
}
