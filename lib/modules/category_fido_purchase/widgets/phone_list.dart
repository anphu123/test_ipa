import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneList extends StatelessWidget {
  final List<String> phones;

  const PhoneList({super.key, required this.phones});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: phones.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey.shade300),
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Row(
            children: [
              Text(
                (i + 1).toString().padLeft(2, '0'),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              SizedBox(width: 12.w),
              Text(phones[i], style: TextStyle(fontSize: 13.sp)),
            ],
          ),
        );
      },
    );
  }
}
