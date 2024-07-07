import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/course_bloc/course_bloc.dart';
import '../widgets/space_tile.dart';
import 'hod_batch_course_per_details_page.dart';

class HodBatchCoursePage extends StatelessWidget {
  final String batchId;

  const HodBatchCoursePage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester $batchId Courses'),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseLoaded) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final course = state.courses[index];
                    return SpaceTile(
                      title: "${course.courseId} - ${course.courseName}",
                      subtitle: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HodBatchCourseDetailsPage(
                              courseFacultyDetails: course,
                            ),
                          ),
                        );
                      },
                    );
                  }, childCount: state.courses.length),
                ),
              ],
            );
          } else if (state is CourseError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
