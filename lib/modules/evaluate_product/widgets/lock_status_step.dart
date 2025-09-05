import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class LockStatusStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;
  const LockStatusStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final locks = [
      {'label': LocaleKeys.normal_startup.trans(), 'offset': 0},
      {'label': LocaleKeys.unable_to_start.trans(), 'offset': -800000},
      {'label': LocaleKeys.new_unopened.trans(), 'offset': 1000000},
    ];

    return StepLayout(
      title: 'Tình trạng khởi động',
      description: '',
      options: locks.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selected = locks.firstWhere(
              (e) => e['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        onSelected(selected['label'] as String, selected['offset'] as int);
      },
    );
  }
}
