import "package:flutter/material.dart";

class SpaceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const SpaceTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        color: Colors.grey[200],
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
