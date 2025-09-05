import 'package:flutter/material.dart';
import '../../../core/theme/app_typography.dart';

class WalletItem extends StatelessWidget {
  final String name;
  final String iconPath;
  final Widget trailing;

  const WalletItem({
    super.key,
    required this.name,
    required this.iconPath,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(iconPath, height: 32),
      title: Text(name, style: AppTypography.s16),
      trailing: IntrinsicWidth( // 👈 đảm bảo trailing không lỗi layout
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            trailing,
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
      onTap: () {
        // Optional: xử lý khi người dùng nhấn vào item
      },
    );
  }
}
