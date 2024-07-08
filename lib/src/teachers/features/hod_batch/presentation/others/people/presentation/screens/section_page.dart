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
            return const Center(child: CircularProgressIndicator());
          } else if (state is PeopleLoaded) {
            return ListView(
              children: [
                _buildSectionHeader('Tutors', Icons.school),
                ...state.tutor.asMap().entries.map((entry) => _buildListItem(entry.key + 1, entry.value.name)),
                _buildSectionHeader('Teachers', Icons.person),
                ...state.teacher.asMap().entries.map((entry) => _buildListItem(entry.key + 1, entry.value.name)),
                _buildSectionHeader('Students', Icons.group),
                ...state.students.asMap().entries.map((entry) => _buildListItem(entry.key + 1, entry.value.name)),
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

  Widget _buildSectionHeader(String title, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(iconData),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        _buildSectionDivider(),
      ],
    );
  }

  Widget _buildListItem(int index, String name) {
    return ListTile(
      title: Text('$index. $name'),
    );
  }

  Widget _buildSectionDivider() {
    return Container(
      child: Divider(),
      padding: EdgeInsets.all(10),
    );
  }
}
