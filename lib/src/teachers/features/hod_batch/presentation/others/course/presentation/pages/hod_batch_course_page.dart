import 'package:flutter/material.dart';

import '../widgets/space_tile.dart';

class HodBatchCoursePage extends StatelessWidget {
  final String batchId;
  const HodBatchCoursePage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester $batchId Courses'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return SpaceTile(
                title: "19CS5$index - Unix Internals",
                subtitle: "S Priya, R Pavithra",
                onTap: () {
                  Navigator.pushNamed(
                      context, "/hod_batch_course_details_page");
                },
              );
            }, childCount: 5),
          ),
        ],
      ),
    );
  }
}
