import 'package:flutter/material.dart';

class StreamAnnounceTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const StreamAnnounceTile(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Icon(
              Icons.person_rounded,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
