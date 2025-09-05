import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/assets/locale_keys.g.dart';
import '../../../core/common_widget/no_diacritics_upper_case_formatter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/add_credit_card_controller.dart';
import '../widgets/show_cvv_dialog.dart';

class AddCreditCardView extends GetView<AddCreditCardController> {
  final issueDateFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral08,
      appBar: AppBar(
        title: Text(
          LocaleKeys.add_credit_debit_account.trans(),
          style: AppTypography.s20.medium.withColor(AppColors.neutral01),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSecureNotice(),
              SizedBox(height: 16),
              Container(
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionTitle(LocaleKeys.card_details.trans()),
                        SizedBox(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                Assets.images.icVisa.path,
                                width: 24,
                                height: 24,
                              ),
                              Image.asset(
                                Assets.images.icMastercard.path,
                                width: 24,
                                height: 24,
                              ),
                              Image.asset(
                                Assets.images.icJcb.path,
                                width: 24,
                                height: 24,
                              ),
                              Image.asset(
                                Assets.images.icAmericanexpress.path,
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 12),
                    _buildInput(LocaleKeys.cardholder_name.trans(), controller.cardHolder),
                    _buildInput(
                      LocaleKeys.card_number.trans(),
                      controller.cardNumber,
                      keyboard: TextInputType.number,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInput(
                            LocaleKeys.expiration_date.trans(),
                            controller.expiryDate,
                            hint: 'dd/MM',
                            keyboard: TextInputType.datetime,
                          ),
                        ),
                         SizedBox(width: 12),
                        Expanded(
                          child: _buildInput(
                            LocaleKeys.cvv_code.trans(),
                            controller.cvv,
                            hint: '***',
                            keyboard: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Container(
                padding:  EdgeInsets.all(16),
                //  margin:  EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(LocaleKeys.card_address.trans()),
                     SizedBox(height: 12),
                    _buildInput(LocaleKeys.address.trans(), controller.address),
                    _buildInput(
                      LocaleKeys.postal_code.trans(),
                      controller.postalCode,
                      keyboard: TextInputType.number,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              _buildVerificationNote(),
              SizedBox(height: 12),
              //_buildConfirmButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ]
          ),
          child: _buildConfirmButton(),
        ),
      ),
    );
  }

  Widget _buildSecureNotice() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(Assets.images.icCheck.path, color: AppColors.AS01),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                    LocaleKeys.card_info_secure.trans(),
                  style: AppTypography.s14.regular.withColor(AppColors.AS01),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            LocaleKeys.card_info_protected.trans(),
            style: AppTypography.s14.regular.withColor(AppColors.neutral03),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.s16.regular.withColor(AppColors.neutral01),
        ),
      ],
    );
  }

  Widget _buildInput(
    String label,
    RxString field, {
    String? hint,
    TextInputType? keyboard,
  }) {
    int? maxLength;
    final isIssueDate = label == LocaleKeys.expiration_date.trans();
    if (label == LocaleKeys.card_number.trans()) maxLength = 16;
    if (label == LocaleKeys.expiration_date.trans()) maxLength = 5;
    if (label == LocaleKeys.cvv_code.trans()) maxLength = 3;

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: keyboard,
        maxLength: maxLength,
        inputFormatters:
            label == LocaleKeys.cardholder_name.trans()
                ? [NoDiacriticsUpperCaseFormatter()]
                : isIssueDate
                ? [issueDateFormatter]
                : null,

        style: AppTypography.s12.regular.withColor(AppColors.neutral01),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppTypography.s12.regular.withColor(AppColors.neutral04),
          hintText: hint ?? label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          counterText: '',
          suffixIcon:
              label == LocaleKeys.cvv_code.trans()
                  ? GestureDetector(
                    // ✅ Xử lý khi icon được nhấn
                    onTap: () => showCvvDialog(Get.context!),

                    child: Padding(
                      padding:  EdgeInsets.all(12),
                      child: Image.asset(Assets.images.icInfo.path, ),
                    ),
                  )
                  : null,
          hintStyle: AppTypography.s12.regular.withColor(AppColors.neutral04),
          contentPadding:  EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade600, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: AppColors.neutral01),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(color: AppColors.neutral01),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(
              color: AppColors.neutral04,
              width: 1.5,
            ),
          ),
        ),
        onChanged: (value) => field.value = value,
        validator: (value) {
          final input = value?.trim() ?? '';
          if (input.isEmpty) return 'Vui lòng nhập $label';

          if (label == LocaleKeys.card_number.trans() && !RegExp(r'^\d{16}$').hasMatch(input)) {
            return 'Số thẻ phải gồm 16 chữ số';
          }

          if (label == LocaleKeys.expiration_date.trans() &&
              !RegExp(r'^\d{2}/\d{2}$').hasMatch(input)) {
            return 'Định dạng ngày phải là dd/MM';
          }

          if (label == LocaleKeys.cvv_code.trans() && !RegExp(r'^\d{3}$').hasMatch(input)) {
            return 'CVV phải gồm 3 chữ số';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildVerificationNote() {
    return Text(
        LocaleKeys.verify_fee_notice.trans(),
      style: AppTypography.s12.regular.withColor(AppColors.neutral04),
    );
  }

  Widget _buildConfirmButton() {
    return GestureDetector(
      onTap: () {
        if (controller.formKey.currentState!.validate()) {
          controller.saveCard();
        }
      },
      child: Container(
        width: double.infinity,
        height: 42.h,
     //   padding:  EdgeInsets.symmetric(vertical: 14),
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
    );
  }

}
