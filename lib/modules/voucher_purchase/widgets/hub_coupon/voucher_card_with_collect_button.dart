// import 'package:fido_box_demo01/modules/voucher_purchase/widgets/voucher_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'collect_button.dart';
//
// class VoucherCardWithCollectButton extends StatefulWidget {
//   @override
//   _VoucherCardWithCollectButtonState createState() => _VoucherCardWithCollectButtonState();
// }
//
// class _VoucherCardWithCollectButtonState extends State<VoucherCardWithCollectButton> {
//   bool isCollected = false;
//
//   void handleCollect() {
//     setState(() {
//       isCollected = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         VoucherCard(
//           // value:value,
//           // condition: "Áp dụng cho đơn hàng trên 500k",
//           isCollected: isCollected,
//         ),
//         SizedBox(height: 16.h),
//         CollectButton(
//           isCollected: isCollected,
//           onCollected: handleCollect,
//         ),
//       ],
//     );
//   }
// }