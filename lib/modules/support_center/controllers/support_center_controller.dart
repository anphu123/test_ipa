import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/assets/locale_keys.g.dart';
import '../domain/faq_model.dart';

class SupportCenterController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final tabs = [ LocaleKeys.suggest.trans(), LocaleKeys.shop_with_2hand.trans(), LocaleKeys.promotions.trans()];
  final currentTabIndex = 0.obs;
  final isExpanded = false.obs;

  final faqData = <int, List<FaqModel>>{
    0: List.generate(8, (i) => FaqModel(question: LocaleKeys.suggest.trans()+' $i', answer: 'Answer $i')),
    1: List.generate(3, (i) => FaqModel(question: LocaleKeys.shop_with_2hand.trans()+' $i', answer: 'Answer $i')),
    2: List.generate(5, (i) => FaqModel(question: LocaleKeys.promotions.trans()+' $i', answer: 'Answer $i')),
  };

  List<FaqModel> getFaqsByTabIndex(int index) => faqData[index] ?? [];

  void toggleExpand() => isExpanded.toggle();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
