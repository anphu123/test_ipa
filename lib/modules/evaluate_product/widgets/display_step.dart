import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class DisplayStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;
  const DisplayStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final displayOptions = [
      {'label': LocaleKeys.normal_screen.trans(), 'offset': 0},
      {'label': LocaleKeys.minor_scratches.trans(), 'offset': -100000},
      {'label': LocaleKeys.light_scratches.trans(), 'offset': -200000},
      {'label': LocaleKeys.obvious_scratches.trans(), 'offset': -300000},
      {'label': LocaleKeys.glue_peeling.trans(), 'offset': -500000},
    ];

    return StepLayout(
      title: 'Màn hình hiển thị',
      description: '',
      options: displayOptions.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selected = displayOptions.firstWhere(
              (e) => e['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        final offset = selected['offset'] as int;
        onSelected(selectedLabel, offset);
      },
    );
  }
}
