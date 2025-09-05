import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrustedInfoBox() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Câu hỏi "Thông tin có hữu ích không?"
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thông tin có hữu ích không ?",
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
            SizedBox(width: 4.w),
            HelpfulButton(),
          ],
        ),
      ),

      // Hộp thông tin xác thực
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE0E8FF), // Xanh nhạt
              const Color(0xFFF3E0FF), // Tím nhạt
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sản phẩm được hệ thống đề xuất",
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
            SizedBox(height: 4.h),
            Text(
              "Sản phẩm này là hàng chụp thật – đảm bảo độ chân thực cao",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Tất cả hình ảnh được người bán chụp trực tiếp qua ứng dụng Fidobox, phản ánh đúng tình trạng thực tế của sản phẩm. Bạn có thể hoàn toàn yên tâm và ưu tiên lựa chọn mua!",
              style: TextStyle(fontSize: 12.sp, color: Colors.black87),
            ),
          ],
        ),
      ),
    ],
  );
}

class HelpfulButton extends StatefulWidget {
  @override
  _HelpfulButtonState createState() => _HelpfulButtonState();
}

class _HelpfulButtonState extends State<HelpfulButton> {
  bool isHelpful = false;
  int helpfulCount = 0;

  void toggleHelpful() {
    setState(() {
      isHelpful = !isHelpful;
      helpfulCount += isHelpful ? 1 : -1;
    });

    // TODO: Call API here if needed
    // await Api.likeHelpful(productId);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleHelpful,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isHelpful ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
            color: isHelpful ? Colors.blue : Colors.grey,
            size: 18,
          ),
          SizedBox(width: 4),
          Text(
            'Hữu ích (${helpfulCount})',
            style: TextStyle(
              color: isHelpful ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
