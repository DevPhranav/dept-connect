import 'package:flutter/material.dart';

import '../../../../../../static/calculate_year.dart';
class BatchTile extends StatelessWidget {
  final String title;
  final String batchYear;
  final VoidCallback onTap;

  const BatchTile({super.key,
    required this.title,
    required this.batchYear,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    String yearText = CalculateYear().getYearText(batchYear);
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
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    yearText,
                    style: const TextStyle(
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


