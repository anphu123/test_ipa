import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class ScreenRepairStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;
  const ScreenRepairStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'label':  LocaleKeys.no_screen_repair.trans(), 'offset': 0},
      {'label':  LocaleKeys.has_screen_repair.trans(), 'offset': -500000},
      {'label':  LocaleKeys.non_genuine_screen.trans(), 'offset': -700000},
      {'label':  LocaleKeys.us_version_hole.trans(), 'offset': -1000000},
    ];

    return StepLayout(
      title:  LocaleKeys.screen_repair_replacement.trans(),
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
