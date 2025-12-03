import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;

  const MyRadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.contentPadding,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: enabled ? onChanged : null,
      title: Text(title),
      contentPadding: contentPadding,
      activeColor: ConstantsColors.secondary,
      hoverColor: ConstantsColors.primary,
    );
  }
}
