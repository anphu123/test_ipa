import 'package:fido_box_demo01/core/assets/locale_keys.g.dart';
import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/common_widget/no_diacritics_upper_case_formatter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/add_bank_account_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class AddBankAccountView extends StatelessWidget {
  final String bankName;
  final controller = Get.put(AddBankAccountController());
  final issueDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  AddBankAccountView({required this.bankName}) {
    controller.bankName.value = bankName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(bankName, style: AppTypography.s16.medium),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 👉 Khối nhập liệu (container trắng)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLinkMethodSelector(),
                    const SizedBox(height: 16),
                    Obx(() {
                      final isAccount =
                          controller.linkMethod.value == LocaleKeys.account_number.trans();
                      return Column(
                        children: [
                          _buildInput(
                            isAccount ? LocaleKeys.account_number.trans() : LocaleKeys.card_number.trans(),
                            controller.accountNumber,
                            TextInputType.number,
                          ),
                          _buildInput(
                            isAccount ? LocaleKeys.account_holder_name.trans() : 'Tên chủ thẻ',
                            controller.accountHolder,
                          ),
                          _buildInput(
                            LocaleKeys.card_issue_date.trans(),
                            controller.issueDate,
                            TextInputType.datetime,
                            'yy/mm',
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// 👉 Note nằm ngoài khối container trên
              Container(width: double.infinity, child: _buildNote()),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              if (controller.formKey.currentState!.validate()) {
                controller.saveAccount();
              }
            },
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.primary01,
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.confirm.trans(),
                style: AppTypography.s16.withColor(AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLinkMethodSelector() {
    return GestureDetector(
      onTap: controller.selectLinkMethod,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral02),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(LocaleKeys.link_method.trans(), style: AppTypography.s14),
            Obx(
              () => Row(
                children: [
                  Text(
                    controller.linkMethod.value,
                    style: AppTypography.s14.bold,
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, RxString field, [TextInputType? keyboard, String? hint]) {
      final isIssueDate = label == LocaleKeys.card_issue_date.trans();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: keyboard,
        inputFormatters: isIssueDate
            ? [issueDateFormatter]
            : label.contains('Tên chủ')
            ? [NoDiacriticsUpperCaseFormatter()]
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: (label == LocaleKeys.account_number.trans() || label == LocaleKeys.card_number.trans())
              ? AppTypography.s12.bold.withColor(AppColors.primary01)
              : AppTypography.s12.withColor(AppColors.neutral04),
          hintText: hint ?? label,
          hintStyle: AppTypography.s12.withColor(AppColors.neutral04),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.neutral01),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.neutral01),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.neutral04, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade600, width: 1.5),
          ),
        ),
        onChanged: (value) => field.value = value,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Vui lòng nhập $label';
          }
          if (isIssueDate && !RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
            return 'Định dạng không hợp lệ (MM/YY)';
          }
          return null;
        },
      ),
    );
  }


  Widget _buildNote() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text:LocaleKeys.pre_link_conditions.trans()  + '\n',
            style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
          ),
          TextSpan(text: LocaleKeys.support_account_link.trans()+'\n'),
          TextSpan(
            text:
             LocaleKeys.support_card_link.trans() +'\n',
          ),
          TextSpan(
            text:
            LocaleKeys.sms_banking_notice.trans()  +'\n',
          ),
          TextSpan(
            text: LocaleKeys.min_balance_required.trans()+'\n',
          ),
          TextSpan(
            text: LocaleKeys.bank_check.trans()+':\n',
            style: AppTypography.s16.semibold.withColor(AppColors.neutral01),
          ),
          TextSpan(
            text:LocaleKeys.info_match_notice.trans()
             //   '- Số điện thoại và CCCD đăng ký Ví 2Hand phải trùng với thông tin đã đăng ký với Ngân hàng.',
          ),
        ],
      ),
      style: AppTypography.s14.regular.withColor(AppColors.neutral03),
    );
  }
}
