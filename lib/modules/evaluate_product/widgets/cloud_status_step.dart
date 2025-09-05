import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class CloudStatusStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;

  const CloudStatusStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final cloudOptions = [
      {'label': LocaleKeys.xiaomicloud_can_logout.trans(), 'offset': 0},
      {'label': LocaleKeys.xiaomicloud_cannot_logout.trans(), 'offset': -1000000},
    ];

    return StepLayout(
      title: 'Tài khoản cá nhân',
      description: '',
      options: cloudOptions.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selected = cloudOptions.firstWhere(
              (e) => e['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        final offset = selected['offset'] as int;
        onSelected(selectedLabel, offset);
      },
    );
  }
}
