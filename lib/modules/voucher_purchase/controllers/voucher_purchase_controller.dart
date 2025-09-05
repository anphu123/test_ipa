import 'package:get/get.dart';
import '../domain/voucher_model.dart';

class VoucherPurchaseController extends GetxController {
  final RxList<VoucherModel> allVouchers = <VoucherModel>[].obs;
  final currentIndex = 0.obs;
  final currentTabIndex = 0.obs;
  final Rxn<VoucherModel> selectedVoucher = Rxn<VoucherModel>();

  @override
  void onInit() {
    super.onInit();
    fetchMockData();
  }

  void onTabWalletChanged(int index) {
    if (currentTabIndex.value != index) {
      currentTabIndex.value = index;
    }
  }

  void onTabChanged(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  void selectVoucher(VoucherModel voucher) {
    selectedVoucher.value = voucher;
    print('VoucherPurchaseController: Selected voucher ${voucher.amount}');
  }

  void clearVoucher() {
    selectedVoucher.value = null;
    print('VoucherPurchaseController: Cleared voucher selection');
  }

  void fetchMockData() {
    allVouchers.assignAll([
      VoucherModel(
        id: '1',
        amount: '500k',
        condition: 'đ8.000.000',
        expiry: '31/12/2025',
        expiryDate: '31/12/2025',
        status: VoucherStatus.available,
        discountAmount: 500000,
      ),
      VoucherModel(
        id: '2',
        amount: '+10%',
        condition: 'đ5.000.000',
        expiry: '31/12/2025',
        expiryDate: '31/12/2025',
        status: VoucherStatus.available,
        discountAmount: 0, // Percentage discount
        discountPercentage: 10,
      ),
      VoucherModel(
        id: '3',
        amount: '300k',
        condition: 'đ3.000.000',
        expiry: '31/12/2025',
        expiryDate: '31/12/2025',
        status: VoucherStatus.available,
        discountAmount: 300000,
      ),
      VoucherModel(
        id: '4',
        amount: '+15%',
        condition: 'đ10.000.000',
        expiry: '15/01/2025',
        expiryDate: '15/01/2025',
        status: VoucherStatus.used,
        discountAmount: 0,
        discountPercentage: 15,
      ),
      VoucherModel(
        id: '5',
        amount: '200k',
        condition: 'đ2.000.000',
        expiry: '01/01/2024',
        expiryDate: '01/01/2024',
        status: VoucherStatus.expired,
        discountAmount: 200000,
      ),
    ]);
    print('VoucherPurchaseController: Loaded ${allVouchers.length} vouchers');
  }

  List<VoucherModel> get availableVouchers {
    final available = allVouchers.where((v) => v.status == VoucherStatus.available).toList();
    print('VoucherPurchaseController: ${available.length} available vouchers');
    return available;
  }

  List<VoucherModel> get usedVouchers =>
      allVouchers.where((v) => v.status == VoucherStatus.used).toList();

  List<VoucherModel> get expiredVouchers =>
      allVouchers.where((v) => v.status == VoucherStatus.expired).toList();

  // Calculate discount for a given price
  int calculateDiscount(VoucherModel voucher, int originalPrice) {
    if (voucher.discountPercentage != null && voucher.discountPercentage! > 0) {
      return (originalPrice * voucher.discountPercentage! / 100).round();
    }
    return voucher.discountAmount ?? 0;
  }

  // Check if voucher is applicable for given price
  bool isVoucherApplicable(VoucherModel voucher, int price) {
    // Extract minimum amount from condition string (e.g., "đ8.000.000" -> 8000000)
    final conditionStr = voucher.condition?.replaceAll(RegExp(r'[^\d]'), '') ?? '0';
    final minAmount = int.tryParse(conditionStr) ?? 0;
    return price >= minAmount;
  }
}