import 'package:flutter/material.dart';

class UserButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const UserButton({Key? key, required this.label, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.grey[200],
        minWidth: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Text(
          label,
        ),
      ),
    );
  }
}
