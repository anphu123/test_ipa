// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../core/assets/assets.gen.dart';
//
// class CskhChatView extends StatefulWidget {
//   final String? initialMessage;
//
//   const CskhChatView({super.key, this.initialMessage});
//
//   @override
//   State<CskhChatView> createState() => _CskhChatViewState();
// }
//
// class _CskhChatViewState extends State<CskhChatView> {
//   final TextEditingController _textController = TextEditingController();
//   final List<String> messages = [];
//
//   final List<String> suggestions = [
//     'Thời hạn thanh toán đơn hàng là bao lâu?',
//     'Tra cứu đơn hàng',
//     'Làm sao để biết sản phẩm có quà tặng kèm?',
//     'Cách kiểm tra chất lượng sản phẩm?',
//     'Sản phẩm được gửi đi bằng dịch vụ vận chuyển nào?',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.initialMessage?.isNotEmpty ?? false) {
//       messages.add(widget.initialMessage!);
//     }
//   }
//
//   void _sendMessage(String text) {
//     if (text.trim().isEmpty) return;
//     setState(() {
//       messages.add(text.trim());
//       _textController.clear();
//     });
//   }
//
//   Widget _buildMessage(String message, {bool isUser = true}) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         decoration: BoxDecoration(
//           color: isUser ? Colors.grey[200] : Colors.orange[50],
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Text(message, style: TextStyle(fontSize: 14.sp)),
//       ),
//     );
//   }
//
//   Widget _buildWelcomeCard() {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       margin: EdgeInsets.symmetric(vertical: 8.h),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFFF4EC),
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Image.asset(Assets.images.bear1.path, width: 40.w, height: 40.w),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Xin chào !', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
//                     Text('Bạn có câu hỏi gì cần giải đáp không?', style: TextStyle(fontSize: 13.sp)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Text('Mọi người cũng hỏi những câu này', style: TextStyle(color: Colors.orange, fontSize: 13.sp)),
//           ...suggestions.map(
//                 (s) => ListTile(
//               dense: true,
//               contentPadding: EdgeInsets.zero,
//               title: Text(s, style: TextStyle(fontSize: 13.sp)),
//               trailing: Icon(Icons.arrow_forward_ios, size: 14.sp),
//               onTap: () => _sendMessage(s),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: OutlinedButton(
//               onPressed: () {},
//               child: Text('Dịch vụ khác', style: TextStyle(fontSize: 13.sp)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget _buildInputField() {
//   //   return Container(
//   //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//   //     child: Row(
//   //       children: [
//   //         Expanded(
//   //           child: TextField(
//   //             controller: _textController,
//   //             decoration: InputDecoration(
//   //               hintText: 'Nhập tin nhắn',
//   //               contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
//   //               border: OutlineInputBorder(
//   //                 borderRadius: BorderRadius.circular(24.r),
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         SizedBox(width: 8.w),
//   //         GestureDetector(
//   //           onTap: () => _sendMessage(_textController.text),
//   //           child: CircleAvatar(
//   //             backgroundColor: Colors.orange,
//   //             child: Icon(Icons.send, color: Colors.white, size: 18.sp),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final showWelcomeCard = messages.isEmpty;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CSKH', style: TextStyle(fontSize: 16.sp)),
//         centerTitle: true,
//         elevation: 0,
//         leading: const BackButton(),
//         actions: [IconButton(icon: const Icon(Icons.more_vert), onPressed: () {})],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//               itemCount: messages.length + (showWelcomeCard ? 2 : 1),
//               itemBuilder: (context, index) {
//                 if (index == 0) {
//                   return Center(
//                     child: Text(
//                       DateFormat('dd/MM/yyyy').format(DateTime.now()),
//                       style: TextStyle(fontSize: 12.sp, color: Colors.grey),
//                     ),
//                   );
//                 }
//                 if (showWelcomeCard && index == 1) {
//                   return _buildWelcomeCard();
//                 }
//                 final messageIndex = index - (showWelcomeCard ? 2 : 1);
//                 return _buildMessage(messages[messageIndex]);
//               },
//             ),
//           ),
//           _buildInputField(),
//         ],
//       ),
//     );
//   }
// }
