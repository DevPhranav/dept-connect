import 'package:flutter/material.dart';

class HodBatchCourseDetailsPage extends StatelessWidget {
  final String batchId;

  const HodBatchCourseDetailsPage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Batch Course Details'),
      ),
      body: Center(
        child: Text('Batch ID: $batchId'),
      ),
    );
  }
}
