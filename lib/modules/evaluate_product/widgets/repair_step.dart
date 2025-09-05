import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class RepairStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;
  const RepairStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'label': LocaleKeys.no_repair.trans(), 'offset': 0},
      {'label': LocaleKeys.has_repair_parts.trans(), 'offset': -400000},
      {'label': LocaleKeys.repair_case_camera.trans(), 'offset': -600000},
      {'label':LocaleKeys.missing_components.trans(), 'offset': -1000000},
    ];

    return StepLayout(
      title: LocaleKeys.repair_replace_parts.trans(),
      description: '',
      options: options.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selected = options.firstWhere(
              (e) => e['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        onSelected(selected['label'] as String, selected['offset'] as int);
      },
    );
  }
}
