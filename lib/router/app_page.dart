import 'package:fido_box_demo01/modules/account/bindings/account_binding.dart';
import 'package:fido_box_demo01/modules/account/views/account_view.dart';
import 'package:fido_box_demo01/modules/account_security/views/account_sercurity_view.dart';
import 'package:fido_box_demo01/modules/account_social/views/account_social_view.dart';
import 'package:fido_box_demo01/modules/address/views/address_view.dart';
import 'package:fido_box_demo01/modules/answer_detail/views/answer_detail_view.dart';
import 'package:fido_box_demo01/modules/brand_store/views/brand_store_view.dart';
import 'package:fido_box_demo01/modules/change_phone_number/views/change_phone_number_view.dart';
import 'package:fido_box_demo01/modules/change_phone_number/widgets/phone_number_change_view.dart';
import 'package:fido_box_demo01/modules/detail_product/bindings/detail_product_binding.dart';
import 'package:fido_box_demo01/modules/favourite/views/favourite_view.dart';
import 'package:fido_box_demo01/modules/for_sale/bindings/for_sale_binding.dart';
import 'package:fido_box_demo01/modules/for_sale/views/for_sale_view.dart';
import 'package:fido_box_demo01/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:fido_box_demo01/modules/forgot_password/views/forgot_password_screen.dart';
import 'package:fido_box_demo01/modules/loading/views/loading_view.dart';
import 'package:fido_box_demo01/modules/notification/views/notification_view.dart';
import 'package:fido_box_demo01/modules/order_purchase_at_home/bindings/order_purchase_at_home_binding.dart';
import 'package:fido_box_demo01/modules/order_purchase_at_home/views/order_purchase_at_home_view.dart';
import 'package:fido_box_demo01/modules/order_purchase_at_store/bindings/order_purchase_at_store_binding.dart';
import 'package:fido_box_demo01/modules/order_purchase_at_store/views/order_purchase_at_store_view.dart';

import 'package:fido_box_demo01/modules/payment_account/views/payment_account_view.dart';
import 'package:fido_box_demo01/modules/register/bindings/register_binding.dart';
import 'package:fido_box_demo01/modules/register/views/register_screen.dart';
import 'package:fido_box_demo01/modules/support_center/views/support_center_view.dart';
import 'package:fido_box_demo01/modules/voucher_purchase/controllers/voucher_purchase_controller.dart';
import 'package:fido_box_demo01/modules/voucher_purchase/views/voucher_purchase_view.dart';
import 'package:get/get.dart';

import '../modules/Open_market/bindings/open_market_binding.dart';
import '../modules/Open_market/views/open_market_view.dart';
import '../modules/about_2hand/bindings/about_2hand_binding.dart';
import '../modules/about_2hand/views/about_2hand_view.dart';
import '../modules/account_security/bindings/account_sercurity_binding.dart';
import '../modules/account_social/bindings/account_social_binding.dart';
import '../modules/add_bank_account/bindings/add_bank_account_binding.dart';
import '../modules/add_bank_account/views/add_bank_account_view.dart';
import '../modules/add_bank_account/views/select_bank_view.dart';
import '../modules/add_credit_card/bindings/add_credit_card_binding.dart';
import '../modules/add_credit_card/views/add_credit_card_view.dart';
import '../modules/address/bindings/address_binding.dart';
import '../modules/answer_detail/bindings/answer_detail_binding.dart';
import '../modules/assessment_evaluation/bindings/assessment_evaluation_binding.dart';
import '../modules/assessment_evaluation/views/assessment_evaluation_view.dart';
import '../modules/block_list/bindings/block_list_binding.dart';
import '../modules/block_list/views/block_list_view.dart';
import '../modules/brand_store/bindings/brand_store_binding.dart';
import '../modules/category_fido_purchase/bindings/category_fido_purchase_binding.dart';
import '../modules/category_fido_purchase/domain/model_variant.dart';
import '../modules/category_fido_purchase/views/category_fido_purchase_view.dart';
import '../modules/change_phone_number/bindings/change_phone_number_binding.dart';
import '../modules/coming_soon/bindings/coming_soon_binding.dart';
import '../modules/coming_soon/views/coming_soon_view.dart';
import '../modules/community_standards/bindings/community_standards_binding.dart';
import '../modules/community_standards/views/community_standards_view.dart';
import '../modules/email_notification/bindings/email_notification_binding.dart';
import '../modules/email_notification/views/email_notification_view.dart';
import '../modules/evaluate_product/bindings/evaluate_product_binding.dart';
import '../modules/evaluate_product/views/evaluate_product_view.dart';
import '../modules/evaluate_result/bindings/evaluate_result_binding.dart';
import '../modules/evaluate_result/views/evaluate_result_view.dart';
import '../modules/fido_purchase/bindings/fido_purchase_binding.dart';
import '../modules/fido_purchase/bindings/seller_review_page_binding.dart';
import '../modules/fido_purchase/views/fido_purchase_view.dart';
import '../modules/fido_purchase/views/seller_review_page.dart';
import '../modules/home_pickup_zone/bindings/home_pickup_zone_binding.dart';
import '../modules/home_pickup_zone/views/home_pickup_zone_view.dart';
import '../modules/in_app_notification/bindings/in_app_notification_binding.dart';
import '../modules/in_app_notification/views/in_app_notification_view.dart';
import '../modules/language_setting/bindings/language_setting_binding.dart';
import '../modules/language_setting/views/language_setting_view.dart';
import '../modules/list_store/bindings/list_store_binding.dart';
import '../modules/list_store/views/list_store_view.dart';
import '../modules/notification_settings/bindings/notification_settings_binding.dart';
import '../modules/notification_settings/views/notification_settings_views.dart';

import '../modules/payment_account/bindings/payment_account_binding.dart';
import '../modules/personal_profile/bindings/personal_profile_binding.dart';
import '../modules/personal_profile/views/personal_profile_view.dart';
import '../modules/privacy_settings/bindings/privacy_settings_binding.dart';
import '../modules/privacy_settings/views/privacy_settings_view.dart';
import '../modules/purchase/bindings/purchase_binding.dart';
import '../modules/purchase/views/purchase_view.dart';
import '../modules/purchase_order/bindings/purchase_order_binding.dart';
import '../modules/purchase_order/views/purchase_order_view.dart';
import '../modules/send_order_purchase/bindings/send_order_purchase_binding.dart';
import '../modules/send_order_purchase/views/send_order_purchase_view.dart';
import '../modules/set_up_push_notifi/bindings/set_up_push_noti_push_binding.dart';
import '../modules/set_up_push_notifi/views/set_up_push_noti_push_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/boarding/bindings/boarding_binding.dart';
import '../modules/boarding/views/splash_view.dart';
import '../modules/consignment_list/bindings/consignment_list_binding.dart';
import '../modules/consignment_list/views/consignment_list_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_product/views/detail_product_screen.dart';
import '../modules/favourite/bindings/favourite_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loading/bindings/loading_binding.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mail_box/bindings/mail_box_binding.dart';
import '../modules/mail_box/views/mail_box_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification_list/bindings/notification_binding.dart';
import '../modules/notification_list/views/notification_list_view.dart';
import '../modules/sms_notification/bindings/sms_notification_binding.dart';
import '../modules/sms_notification/views/sms_notification_view.dart';
import '../modules/support_center/bindings/support_center_binding.dart';
import '../modules/support_chat/bindings/support_chat_binding.dart';
import '../modules/support_chat/view/support_chat_view.dart';
import '../modules/terms_policies/bindings/terms_policies_binding.dart';
import '../modules/terms_policies/views/terms_policies_view.dart';
import '../modules/user_identification/bindings/user_identification_binding.dart';
import '../modules/user_identification/views/user_identification_view.dart';
import '../modules/voucher_purchase/bindings/voucher_purchase_binding.dart';
import '../modules/voucher_purchase/widgets/voucher_wallet/voucher_wallet.dart';
import '../modules/zalo_notification/bindings/zalo_notification_binding.dart';
import '../modules/zalo_notification/views/zalo_notification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initPage = Routes.loading;

  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: BoardingBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => DashBoardView(),
      binding: DashboardBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: Routes.loading,
      page: () => LoadingScreen(),
      binding: LoadingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.detailProduct,
      page: () => DetailProductScreen(),
      binding: DetailProductBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.account,
      page: () => AccountScreen(),
      binding: AccountBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.mailbox,
      page: () => MailBoxView(),
      binding: MailBoxBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.openmarket,
      page: () => OpenMarketView(),
      binding: OpenMarketBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.supportchat,
      page: () => SupportChatView(),
      binding: SupportChatBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.notification,
      page: () => NotificationView(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.notificationList,
      page: () => NotificationListView(),
      binding: NotificationListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.consignmentList,
      page: () => ConsignmentListView(),
      binding: ConsignmentListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.favourite,
      page: () => FavouriteView(),
      binding: FavouriteBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.setting,
      page: () => SettingView(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.persionalProfile,
      page: () => PersonalProfileView(),
      binding: PersonalProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.forSale,
      page: () => ForSaleView(),
      binding: ForSaleBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.fidoPurchase,
      page: () => FidoPurchaseView(),
      binding: FidoPurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.sellerReview,
      page: () => SellerReviewPage(),
      binding: FidoPurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.voucherPurchase,
      page: () => VoucherPurchaseView(),
      binding: VoucherPurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.categoryFidoPurchase,
      page: () => CategoryFidoPurchaseView(),
      binding: CategoryFidoPurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.purchase,
      page: () => PurchaseView(),
      binding: PurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.addCreditCard,
      page: () => AddCreditCardView(),
      binding: AddCreditCardBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.accountSecurity,
      page: () => AccountSecurityView(),
      binding: AccountSecurityBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.changePhoneNumber,
      page: () => ChangePhoneNumberView(),
      binding: ChangePhoneNumberBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.phoneChangeNumber,
      page: () => PhoneChangeNumberView(),
      binding: ChangePhoneNumberBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.accountSocial,
      page: () => AccountSocialView(),
      binding: AccountSocialBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.address,
      page: () => AddressView(),
      binding: AddressBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.paymentAccount,
      page: () => PaymentAccountView(),
      binding: PaymentAccountBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.selectBank,
      page: () => SelectBankView(),
      binding: AddBankAccountBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.paymentAccount,
      page: () => AddBankAccountView(bankName: ''),
      binding: AddBankAccountBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.setUpPushNotiPush,
      page: () => SetUpPushNotiPushView(),
      binding: SetUpPushNotiPushBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.notificationSetting,
      page: () => NotificationSettingsView(),
      binding: NotificationSettingsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.inAppNotification,
      page: () => InAppNotificationView(),
      binding: InAppNotificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.emailNotification,
      page: () => EmailNotificationView(),
      binding: EmailNotificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.smsNotification,
      page: () => SmsNotificationView(),
      binding: SmsNotificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.zaloNotification,
      page: () => ZaloNotificationView(),
      binding: ZaloNotificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.privacySetting,
      page: () => PrivacySettingsView(),
      binding: PrivacySettingsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.blockList,
      page: () => BlockListView(),
      binding: BlockListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.languageSetting,
      page: () => LanguageSettingView(),
      binding: LanguageSettingBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.supportCenter,
      page: () => SupportCenterView(),
      binding: SupportCenterBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.answerDetails,
      page: () => AnswerDetailView(),
      binding: AnswerDetailBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.communityStandards,
      page: () => CommunityStandardsView(),
      binding: CommunityStandardsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.termsPolicies,
      page: () => TermsPoliciesView(),
      binding: TermsPoliciesBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.about2Hand,
      page: () => About2HandView(),
      binding: About2HandBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.userIdentification,
      page: () => UserIdentificationView(),
      binding: UserIdentificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.identificationDetail,
      page: () => InAppNotificationView(),
      // binding: UserIdentificationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.purchaseOrder,
      page: () => PurchaseOrderView(),
      binding: PurchaseOrderBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.sendOrderPurchase,
      page: () => SendOrderPurchaseView(),
      binding: SendOrderPurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.evaluateProduct,
      page: () => EvaluateProductView(variant: Get.arguments as ModelVariant),
      binding: EvaluateProductBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    // GetPage(
    //   name: Routes.evaluateResult,
    //   page: () => EvaluateResultView(),
    //   binding: EvaluateResultBinding(),
    //   transition: Transition.rightToLeft,
    //   transitionDuration: const Duration(milliseconds: 300),
    // ),
    GetPage(
      name: Routes.assessmentEvaluation,
      page: () => AssessmentEvaluationView(),
      binding: AssessmentEvaluationBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.walletVoucher,
      page: () => VoucherWalletView(),
      binding: VoucherPurchaseBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.listStore,
      page: () => ListStoreView(),
      binding: ListStoreBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.homePickupZone,
      page: () => HomePickupZoneView(),
      binding: HomePickupZoneBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.orderPurchase,
      page: () => OrderPurchaseAtHomeView(),
      binding: OrderPurchaseAtHomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.orderPurchaseAtStore,
      page: () => OrderPurchaseAtStoreView(),
      binding: OrderPurchaseAtStoreBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.comingSoon,
      page: () => ComingSoonView(),
      binding: ComingSoonBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.brandStore,
      page: () => BrandStoreView(),
      binding: BrandStoreBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
