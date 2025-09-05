import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/assets/assets.gen.dart';
import '../domain/purchase_order_model.dart';

class PurchaseOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final RxList<PurchaseOrderModel> allOrders = <PurchaseOrderModel>[].obs;
  final RxList<PurchaseOrderModel> filteredOrders = <PurchaseOrderModel>[].obs;

  final Rx<OrderStatus> selectedStatus = OrderStatus.all.obs;
  final RxInt index = 0.obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_onTabChanged);

    // Theo dõi mọi thay đổi để cập nhật danh sách đã lọc
    ever<List<PurchaseOrderModel>>(allOrders, (_) => _updateFilteredOrders());
    ever<OrderStatus>(selectedStatus, (_) => _updateFilteredOrders());
    ever<String>(searchQuery, (_) => _updateFilteredOrders());

    _loadMockData();
  }

  @override
  void onClose() {
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    super.onClose();
  }

  void _onTabChanged() {
    if (!tabController.indexIsChanging) {
      index.value = tabController.index;
      selectedStatus.value = OrderStatus.values[tabController.index];
    }
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }

  int get processingCount =>
      allOrders.where((e) => e.status == OrderStatus.processing).length;

  void _updateFilteredOrders() {
    final query = searchQuery.value.toLowerCase();
    final status = selectedStatus.value;

    final baseList = status == OrderStatus.all
        ? allOrders
        : allOrders.where((e) => e.status == status).toList();

    if (query.isEmpty) {
      filteredOrders.assignAll(baseList);
    } else {
      filteredOrders.assignAll(
        baseList.where((order) {
          final combined = [
            order.productName,
            order.statusText,
            order.source.label,
            order.id,
          ].join(' ').toLowerCase();
          return combined.contains(query);
        }),
      );
    }
  }

  void _loadMockData() {
    allOrders.addAll([
      PurchaseOrderModel(
        id: '1',
        productName: 'Xiaomi 15 Ultra',
        productImage: Assets.images.logoNew.path,
        source: PurchaseSource.twoHand,
        statusText: 'Chờ gửi hàng',
        status: OrderStatus.processing,
      ),
      PurchaseOrderModel(
        id: '2',
        productName: 'Đồng hồ I&W Carnival',
        productImage: Assets.images.logoNew.path,
        source: PurchaseSource.consignment,
        statusText: 'Chờ vận chuyển',
        status: OrderStatus.processing,
      ),
      PurchaseOrderModel(
        id: '3',
        productName: 'Xiaomi 15 Ultra',
        productImage: Assets.images.logoNew.path,
        source: PurchaseSource.consignment,
        statusText: 'Chờ vận chuyển',
        status: OrderStatus.processing,
      ),
      PurchaseOrderModel(
        id: '4',
        productName: 'Xiaomi 15 Ultra',
        productImage: Assets.images.logoNew.path,
        source: PurchaseSource.consignment,
        statusText: 'Đã huỷ',
        status: OrderStatus.canceled,
      ),
      PurchaseOrderModel(
        id: '5',
        productName: 'Xiaomi 15 Ultra',
        productImage: Assets.images.logoNew.path,
        source: PurchaseSource.consignment,
        statusText: 'Hoàn thành',
        status: OrderStatus.completed,
      ),
    ]);
  }
}
