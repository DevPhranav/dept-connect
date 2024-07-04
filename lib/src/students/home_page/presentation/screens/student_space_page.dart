import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/students/home_page/presentation/widgets/student_batch_tile.dart';
import '../../../../../../static/drawer.dart';
import '../../../../authentication/auth/data/models/auth_user_model.dart';
import '../../../student_stream/presentation/bloc/student_message_show_bloc/message_show_bloc.dart';
import '../../../student_stream/presentation/bloc/student_message_show_bloc/message_show_event.dart';
import '../../../student_stream/presentation/screens/student_batch_stream_page.dart';
class StudentSpacePage extends StatefulWidget {
  final AuthUserModel? user;

  const StudentSpacePage({super.key, required this.user});

  @override
  StudentSpacePageState createState() => StudentSpacePageState();
}

class StudentSpacePageState extends State<StudentSpacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dept Connect"),
        centerTitle: true,
      ),
      drawer: DeptDrawer(user:widget.user),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return StudentBatchTile(
                  title: widget.user?.batchId ?? 'No Batch ID',
                  onTap: () {
                    BlocProvider.of<StudentMessageBloc>(context).add(StudentLoadMessagesEvent(batchId: widget.user?.batchId));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentBatchStreamPage(
                          batchId: widget.user?.batchId ?? 'No Batch ID',
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
