import 'package:flutter/material.dart';

import '../../../../../../static/calculate_year.dart';
class StudentBatchTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const StudentBatchTile({super.key,
    required this.title,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    String yearText = CalculateYear().getYearText(title);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        color: Colors.grey[200],
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top:25.0,right:25.0,bottom:25.0,left:10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Batch : $title",
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


