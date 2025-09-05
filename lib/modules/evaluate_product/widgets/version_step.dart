import 'package:fido_box_demo01/core/extensions/string_extension.dart';
import 'package:fido_box_demo01/modules/evaluate_product/widgets/step_layout.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/locale_keys.g.dart';

class VersionStep extends StatelessWidget {
  final Function(String label, int offset) onSelected;

  const VersionStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final versions = [
      {'label': LocaleKeys.domestic_version.trans(), 'offset': -500000},
      {'label': LocaleKeys.hk_macao_taiwan_version.trans(), 'offset': -300000},
      {'label': LocaleKeys.other_versions.trans(), 'offset': 0},
      {'label': LocaleKeys.other_versions_locked.trans(), 'offset': -700000},
    ];

    return StepLayout(
      title: LocaleKeys.machine_version.trans(),
      description: '',
      options: versions.map((e) => e['label'] as String).toList(),
      onSelected: (selectedLabel) {
        final selected = versions.firstWhere(
              (e) => e['label'] == selectedLabel,
          orElse: () => {'label': selectedLabel, 'offset': 0},
        );
        onSelected(selected['label'] as String, selected['offset'] as int);
      },
    );
  }
}
