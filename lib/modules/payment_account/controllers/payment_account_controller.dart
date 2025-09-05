import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../add_bank_account/domain/bank_account_model.dart';
import '../domain/credit_card_model.dart';

class PaymentAccountController extends GetxController {
  final box = GetStorage();

  // ví dụ: load danh sách thẻ
  final cards = <CreditCardModel>[].obs;
  final bankAccounts = <BankAccountModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCards();
    loadBankAccounts();
  }

  void loadCards() {
    final raw = box.read<List>('saved_cards') ?? [];
    cards.assignAll(raw.map((e) => CreditCardModel.fromJson(Map<String, dynamic>.from(e))));
  }

  void saveCard(CreditCardModel card) {
    cards.add(card);
    box.write('saved_cards', cards.map((e) => e.toJson()).toList());
  }
  void loadBankAccounts() {
    final data = box.read<List>('linked_banks') ?? [];
    bankAccounts.assignAll(
      data.map((e) => BankAccountModel.fromJson(Map<String, dynamic>.from(e))),
    );
  }
}
