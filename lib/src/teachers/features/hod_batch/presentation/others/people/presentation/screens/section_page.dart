import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/people_bloc.dart';
import '../blocs/people_event.dart';
import '../blocs/people_state.dart';

class SectionPage extends StatelessWidget {
  final String batchId;
  final String section;

  const SectionPage({Key? key, required this.batchId, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dispatch the LoadPeople event when the widget is built
    context.read<PeopleBloc>().add(LoadPeople(
      batchId: batchId,
      section: section,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Section $section'),
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          if (state is PeopleLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PeopleLoaded) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Tutors'),
                ),
                ...state.tutor.map((tutor) => ListTile(title: Text(tutor.name))),
                ListTile(
                  title: Text('Teachers'),
                ),
                ...state.teacher.map((teacher) => ListTile(title: Text(teacher.name))),
                ListTile(
                  title: Text('Students'),
                ),
                ...state.students.map((student) => ListTile(title: Text(student.name))),
              ],
            );
          } else if (state is PeopleError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
