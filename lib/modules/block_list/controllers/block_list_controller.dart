import 'package:get/get.dart';

import '../domain/blocked_user_model.dart';

class BlockListController extends GetxController{
  final blockedUsers = <BlockedUserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBlockedUsers();
  }

  void fetchBlockedUsers() {
    blockedUsers.assignAll([
      BlockedUserModel(id: '1', username: 'hoangvu_91', avatarUrl: ''),
      BlockedUserModel(id: '2', username: 'linhnguyen', avatarUrl: ''),
      BlockedUserModel(id: '3', username: 'huydoan.dev', avatarUrl: ''),
      BlockedUserModel(id: '4', username: 'tramy2000', avatarUrl: ''),
      BlockedUserModel(id: '5', username: 'ngocanh2512', avatarUrl: ''),
      BlockedUserModel(id: '6', username: 'khanhtran_22', avatarUrl: ''),
      BlockedUserModel(id: '7', username: 'duongpham', avatarUrl: ''),
      BlockedUserModel(id: '8', username: 'quangminh', avatarUrl: ''),
      BlockedUserModel(id: '9', username: 'hanh.le', avatarUrl: ''),
      BlockedUserModel(id: '10', username: 'vanhung112', avatarUrl: ''),
    ]);
  }


  void unblockUser(String userId) {
    blockedUsers.removeWhere((user) => user.id == userId);
    // TODO: Gọi API huỷ chặn ở đây nếu có
  }
}