import 'package:flutter/material.dart';

import '../../../core/theme/app_typography.dart';

class BankAccountRow extends StatelessWidget {
  final String iconPath;
  final String bankName;
  final String accountNumber;

  const BankAccountRow({
    required this.iconPath,
    required this.bankName,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(iconPath, height: 32),
            const SizedBox(width: 8),
            Text(bankName, style: AppTypography.s16),
          ],
        ),
        Row(
          children: [
            Text(accountNumber, style: AppTypography.s14),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ],
    );
  }
}
