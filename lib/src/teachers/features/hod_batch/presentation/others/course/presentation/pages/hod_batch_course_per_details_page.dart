import 'package:flutter/material.dart';

import '../../domain/entities/course_faculty_details.dart';

class HodBatchCourseDetailsPage extends StatelessWidget {
  final CourseFacultyDetails courseFacultyDetails;

  const HodBatchCourseDetailsPage({Key? key, required this.courseFacultyDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Course ID', courseFacultyDetails.courseId),
            _buildDetailItem('Section', courseFacultyDetails.section),
            _buildDetailItem('Faculty Name', courseFacultyDetails.facultyName),
            _buildDetailItem('Faculty Email', courseFacultyDetails.facultyEmail),
            _buildDetailItem('Course Name', courseFacultyDetails.courseName),
            _buildDetailItem('Course Credit', courseFacultyDetails.courseCredit),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
