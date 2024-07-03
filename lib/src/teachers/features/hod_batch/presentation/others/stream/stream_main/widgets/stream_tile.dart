import 'package:flutter/material.dart';

class StreamTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const StreamTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.grey[350],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Text(subtitle),
        ],
      ),
    );
  }
}
