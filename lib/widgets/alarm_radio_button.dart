import 'package:flutter/material.dart';

class AlarmRadioButton extends StatelessWidget {
  final String radioName;
  final String groupValue;
  final String radioValue;
  final Function(String? value) onChanged;
  const AlarmRadioButton(
      {Key? key,
      required this.groupValue,
      required this.radioValue,
      required this.onChanged,
      required this.radioName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: radioValue,
          groupValue: groupValue,
          onChanged: (String? value) {
            onChanged(value);
          },
        ),
        Text(
          radioName,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
