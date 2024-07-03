

import 'package:flutter/material.dart';

class FileNameDisplay extends StatelessWidget {
  final String fileName;
  final double maxWidth;

  const FileNameDisplay({super.key, required this.fileName, required this.maxWidth});




  @override
  Widget build(BuildContext context) {
    // Function to truncate file name
    String truncateFileName(String fileName, int maxLength) {
      int extIndex = fileName.lastIndexOf('.');
      if (extIndex == -1) {
        return fileName.length > maxLength ? fileName.substring(0, maxLength) + '...' : fileName;
      }

      String baseName = fileName.substring(0, extIndex);
      String extension = fileName.substring(extIndex);

      if (baseName.length > maxLength) {
        baseName = baseName.substring(0, maxLength) + '...';
      }

      return baseName + extension;
    }

    String finalFileName = truncateFileName(fileName, 15); // Adjust maxLength as needed

    return Text(
        finalFileName,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
  }
}
