import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class WarrantyStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;

  const WarrantyStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final warranties = [
      {'label': LocaleKeys.warranty_over_1_month.trans(), 'offset': 0},
      {'label': LocaleKeys.warranty_expired_1_month.trans(), 'offset': -200000},
    ];

    return StepLayout(
      title: 'Thời hạn bảo hành',
      description: '',
      options: warranties.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selected = warranties.firstWhere(
              (e) => e['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        onSelected(selected['label'] as String, selected['offset'] as int);
      },
    );
  }
}
