import 'package:flutter/material.dart';

class CheckboxTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxTile({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged, activeColor: Colors.black,),
        Text(label),
      ],
    );
  }
}
