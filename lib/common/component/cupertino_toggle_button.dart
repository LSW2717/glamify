import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class CupertinoToggleSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;

  const CupertinoToggleSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: main1,
      value: value,
      onChanged: onChanged,
    );
  }
}
