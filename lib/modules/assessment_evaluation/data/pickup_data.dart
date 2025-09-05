import '../constants/pickup_constants.dart';
import '../domain/pickup_models.dart';
import '../../../core/assets/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class PickupData {
  static List<TabData> getTabsData() {
    return [
      TabData(
        title: LocaleKeys.pickup_store_title.tr(),
        // icon: PickupConstants.storeIcon,
        topRowTexts: [
          LocaleKeys.pickup_common_safe.tr(),
          LocaleKeys.pickup_store_free_data_transfer.tr(),
          LocaleKeys.pickup_common_privacy.tr(),
        ],
        steps: [
          ProcessStep(icon: PickupConstants.basketIcon, title: LocaleKeys.pickup_store_step1.tr()),
          ProcessStep(icon: PickupConstants.timeIcon, title: LocaleKeys.pickup_store_step2.tr()),
          ProcessStep(icon: PickupConstants.chatIcon, title: LocaleKeys.pickup_store_step3.tr()),
          ProcessStep(icon: PickupConstants.walletIcon, title: LocaleKeys.pickup_store_step4.tr()),
        ],
        bottomSheetTitle: LocaleKeys.pickup_store_bottom_title.tr(),
        bottomSheetSubTitle: LocaleKeys.pickup_store_bottom_subtitle.tr(),
        processInfo: [
          ProcessInfo(
            title: LocaleKeys.pickup_store_info1_title.tr(),
            description: LocaleKeys.pickup_store_info1_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_store_info2_title.tr(),
            description: LocaleKeys.pickup_store_info2_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_store_info3_title.tr(),
            description: LocaleKeys.pickup_store_info3_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_store_info4_title.tr(),
            description: LocaleKeys.pickup_store_info4_desc.tr(),
          ),
        ],
      ),
      TabData(
        title: LocaleKeys.pickup_home_title.tr(),
        // icon: PickupConstants.homeIcon,
        topRowTexts: [
          LocaleKeys.pickup_common_safe.tr(),
          LocaleKeys.pickup_home_support_1v1.tr(),
          LocaleKeys.pickup_common_privacy.tr(),
        ],
        steps: [
          ProcessStep(icon: PickupConstants.scheduleIcon, title: LocaleKeys.pickup_home_step1.tr()),
          ProcessStep(icon: PickupConstants.scheduleIcon, title: LocaleKeys.pickup_home_step2.tr()),
          ProcessStep(icon: PickupConstants.verifiedIcon, title: LocaleKeys.pickup_home_step3.tr()),
          ProcessStep(icon: PickupConstants.paymentIcon, title: LocaleKeys.pickup_home_step4.tr()),
        ],
        bottomSheetTitle: LocaleKeys.pickup_home_bottom_title.tr(),
        bottomSheetSubTitle: LocaleKeys.pickup_home_bottom_subtitle.tr(),
        processInfo: [
          ProcessInfo(
            title: LocaleKeys.pickup_home_info1_title.tr(),
            description: LocaleKeys.pickup_home_info1_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_home_info2_title.tr(),
            description: LocaleKeys.pickup_home_info2_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_home_info3_title.tr(),
            description: LocaleKeys.pickup_home_info3_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_home_info4_title.tr(),
            description: LocaleKeys.pickup_home_info4_desc.tr(),
          ),
        ],
      ),
      TabData(
        title: LocaleKeys.pickup_ship_title.tr(),
        // icon: PickupConstants.shippingIcon,
        topRowTexts: [
          LocaleKeys.pickup_common_safe.tr(),
          LocaleKeys.pickup_ship_compensate_mistake.tr(),
          LocaleKeys.pickup_ship_compensate_late.tr(),
          LocaleKeys.pickup_ship_compensate_loss.tr(),
          LocaleKeys.pickup_common_privacy.tr(),
        ],
        steps: [
          ProcessStep(icon: PickupConstants.inventoryIcon, title: LocaleKeys.pickup_ship_step1.tr()),
          ProcessStep(icon: PickupConstants.postOfficeIcon, title: LocaleKeys.pickup_ship_step2.tr()),
          ProcessStep(icon: PickupConstants.searchIcon, title: LocaleKeys.pickup_ship_step3.tr()),
          ProcessStep(icon: PickupConstants.bankIcon, title: LocaleKeys.pickup_ship_step4.tr()),
        ],
        bottomSheetTitle: LocaleKeys.pickup_ship_bottom_title.tr(),
        bottomSheetSubTitle: LocaleKeys.pickup_ship_bottom_subtitle.tr(),
        processInfo: [
          ProcessInfo(
            title: LocaleKeys.pickup_ship_info1_title.tr(),
            description: LocaleKeys.pickup_ship_info1_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_ship_info2_title.tr(),
            description: LocaleKeys.pickup_ship_info2_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_ship_info3_title.tr(),
            description: LocaleKeys.pickup_ship_info3_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_ship_info4_title.tr(),
            description: LocaleKeys.pickup_ship_info4_desc.tr(),
          ),
          ProcessInfo(
            title: LocaleKeys.pickup_ship_info5_title.tr(),
            description: LocaleKeys.pickup_ship_info5_desc.tr(),
          ),
        ],
      ),
    ];
  }
}
