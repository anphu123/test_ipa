import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class AppearanceStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;

  const AppearanceStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = [
      {
        'label': LocaleKeys.perfect_almost_unused.trans(),
        'offset': 0,
      },
      {
        'label':LocaleKeys.scratched_little_used.trans(),
        'offset': -200000,
      },
      {
        'label': LocaleKeys.impact_regular_use.trans(),
        'offset': -400000,
      },
      {
        'label': LocaleKeys.broken_case.trans(),
        'offset': -700000,
      },
    ];

    return StepLayout(
      title: LocaleKeys.case_bezel.trans(),
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
