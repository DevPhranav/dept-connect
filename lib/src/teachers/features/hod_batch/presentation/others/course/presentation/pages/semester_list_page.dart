import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_courses_usecase.dart';
import '../bloc/course_bloc/course_bloc.dart';
import '../bloc/semester_course_bloc/semester_course_bloc.dart';
import '../bloc/semester_course_bloc/semester_course_event.dart';
import '../bloc/semester_course_bloc/semester_course_state.dart';
import '../widgets/semester_section_tile.dart';
import 'hod_batch_course_page.dart';

class SemesterListView extends StatelessWidget {
  final String batchId;

  const SemesterListView({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SemesterBloc, SemesterState>(
      builder: (context, state) {
        if (state is SemesterLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SemesterLoaded) {
          return ListView.builder(
            itemCount: state.semesters.length,
            itemBuilder: (context, index) {
              final semester = state.semesters[index];
              return SemSectionTile(
                key: Key('semester_tile_$index'),
                title: semester.title,
                onTap: () {
                  String semesterNo=(index+1).toString();
                  context.read<CourseBloc>().add(LoadCourses(batchId,semesterNo));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HodBatchCoursePage(
                        batchId: semester.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is SemesterError) {
          return Center(child: Text(state.message));
        } else {
          context.read<SemesterBloc>().add(LoadSemesters(batchId));
          return Center(child: Text('Please wait...'));
        }
      },
    );
  }
}