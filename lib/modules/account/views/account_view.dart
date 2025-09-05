import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/widgets/list_product.dart';
import '../controllers/account_controller.dart';
import '../widgets/account_stat_bar.dart';
import '../widgets/avatar_picker_widget.dart';
import '../widgets/purchase_sell_bar.dart';
import '../widgets/service_shortcut_bar.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral07,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWithAvatar(),

            AccountStatBar(),
            PurchaseSellBar(),
            ServiceShortcutBar(),
            //    ArtistListView(),
            ListProduct(),
            //ArtistFilter(),
            // Thêm ListProduct vào đây để hiển thị danh sách sản phẩm
          ],
        ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     //width: double.infinity,
  //     // height: 150.h,
  //     padding: EdgeInsets.only(
  //       top: 40.h,
  //       left: 16.w,
  //       right: 16.w,
  //       bottom: 16.h,
  //     ),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [Color(0xFFFFB200), Color(0xFFFF6B00)],
  //         begin: Alignment.topLeft,
  //         end: Alignment.bottomRight,
  //       ),
  //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
  //     ),
  //     child: Row(
  //       children: [
  //         CircleAvatar(
  //           radius: 28.r,
  //           backgroundImage: NetworkImage(
  //             'https://media.licdn.com/dms/image/v2/D5635AQHwcJvQ2RgOuQ/profile-framedphoto-shrink_200_200/profile-framedphoto-shrink_200_200/0/1712476452606?e=1751364000&v=beta&t=FPnpAlqSerp-w8OgKR2M_t8zAbXzIiFPv3xtpGsT5HY', // Avatar tạm thời
  //           ),
  //         ),
  //         SizedBox(width: 12.w),
  //
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "XiaoYu",
  //               // '${controller.username.value} !',
  //               style: AppTypography.s16.bold.withColor(Colors.white),
  //             ),
  //             Text(
  //               'Điểm cacbon 0',
  //               style: AppTypography.s12.withColor(Colors.white70),
  //             ),
  //           ],
  //         ),
  //         Spacer(),
  //         IconButton(
  //           icon: Icon(Icons.view_list_rounded, color: Colors.white),
  //           onPressed: () {},
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.settings, color: Colors.white),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
