import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class BatteryStatusStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;

  const BatteryStatusStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'label': '91%-100%', 'offset': 0},
      {'label': '81%-90%', 'offset': -150000},
      {'label': LocaleKeys.battery_80_or_less.trans(), 'offset': -300000},
      {'label': LocaleKeys.battery_repaired_replaced.trans(), 'offset': -400000},
    ];

    return StepLayout(
      title: LocaleKeys.battery_status.trans(),
      description: '',
      options: options.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selectedOption = options.firstWhere(
              (item) => item['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        final offset = selectedOption['offset'] as int;
        onSelected(selectedLabel, offset);
      },
    );
  }
}
