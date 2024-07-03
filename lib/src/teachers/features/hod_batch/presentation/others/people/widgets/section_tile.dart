import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SectionTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        color: Colors.grey[200],
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
