import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../payment_account/controllers/payment_account_controller.dart';
import '../domain/bank_account_model.dart';

class AddBankAccountController extends GetxController {
  final bankName = ''.obs;
  final accountNumber = ''.obs;
  final accountHolder = ''.obs;
  final issueDate = ''.obs;
  final linkMethod = LocaleKeys.account_number.trans().obs;

  final linkMethods = [LocaleKeys.account_number.trans(), 'Số thẻ'];

  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  final bankAccounts = <BankAccountModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    print('AddBankAccountController: onInit called');
    loadBankAccounts();
  }

  void loadBankAccounts() {
    print('AddBankAccountController: loading bank accounts');
    final data = box.read<List>('linked_banks') ?? [];
    print('AddBankAccountController: raw data from storage: $data');
    
    bankAccounts.assignAll(
      data.map((e) => BankAccountModel.fromJson(Map<String, dynamic>.from(e))),
    );
    print('AddBankAccountController: loaded ${bankAccounts.length} bank accounts');
  }

  void saveAccount() {
    print('AddBankAccountController: saving new account');
    print('AddBankAccountController: bankName: ${bankName.value}');
    print('AddBankAccountController: accountNumber: ${accountNumber.value.trim()}');
    print('AddBankAccountController: accountHolder: ${accountHolder.value.trim()}');
    print('AddBankAccountController: issueDate: ${issueDate.value.trim()}');
    
    final newAccount = BankAccountModel(
      bankName: bankName.value,
      accountNumber: accountNumber.value.trim(),
      accountHolder: accountHolder.value.trim(),
      issueDate: issueDate.value.trim(),
    );

    bankAccounts.add(newAccount);
    print('AddBankAccountController: added new account, total accounts: ${bankAccounts.length}');
    
    final accountsJson = bankAccounts.map((e) => e.toJson()).toList();
    box.write('linked_banks', accountsJson);
    print('AddBankAccountController: saved accounts to storage: $accountsJson');

    // Gọi cập nhật lại ở PaymentAccountController
    try {
      final paymentCtrl = Get.find<PaymentAccountController>();
      paymentCtrl.loadBankAccounts();
      print('AddBankAccountController: updated PaymentAccountController');
    } catch (e) {
      print('AddBankAccountController: error updating PaymentAccountController: $e');
    }

    showSuccessDialog(); // Quay lại sau khi lưu
  }

  void showSuccessDialog() {
    print('AddBankAccountController: showing success dialog');
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
                LocaleKeys.success.trans(),
                style: AppTypography.s16.bold.withColor(AppColors.neutral01),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                LocaleKeys.account_link_success.trans(),
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
      print('AddBankAccountController: closing success dialog and navigating back');
      Get.back(); // Đóng dialog
      Get.back(); // Quay lại màn hình trước
    });
  }

  void selectLinkMethod() {
    print('AddBankAccountController: opening link method selection dialog');
    print('AddBankAccountController: current link method: ${linkMethod.value}');
    print('AddBankAccountController: available methods: $linkMethods');
    
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 400),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
                  () => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.link_method.trans(),
                      style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
                    ),
                    const SizedBox(height: 8),
                    ...linkMethods.map(
                          (method) => GestureDetector(
                        onTap: () {
                          print('AddBankAccountController: selected link method: $method');
                          linkMethod.value = method;
                          Get.back();
                        },
                        child: Container(
                          // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(method, style: AppTypography.s14),
                              Radio<String>(
                                value: method,
                                groupValue: linkMethod.value,
                                onChanged: (val) {
                                  if (val != null) {
                                    print('AddBankAccountController: radio selected: $val');
                                    linkMethod.value = val;
                                    Get.back();
                                  }
                                },
                                activeColor: AppColors.primary01,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}