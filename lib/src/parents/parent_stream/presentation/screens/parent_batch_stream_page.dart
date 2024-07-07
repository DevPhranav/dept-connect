import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/models/auth_user_model.dart';
import 'package:miniproject_authentication/src/parents/parent_stream/presentation/screens/parent_message_details_page.dart';
import '../../../../../../../../../../static/calculate_year.dart';
import '../../../../../../../../../../static/date_to_display_format.dart';
import '../../../../../static/drawer.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_bloc.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_event.dart';
import '../bloc/student_message_show_bloc/message_show_bloc.dart';
import '../bloc/student_message_show_bloc/message_show_event.dart';
import '../bloc/student_message_show_bloc/message_show_state.dart';
import '../widgets/message_tile.dart';

class ParentBatchStreamPage extends StatefulWidget {

  final AuthUserModel? user;
  final String batchId;

  const ParentBatchStreamPage({super.key, this.user, required this.batchId});
  @override
  _ParentBatchStreamPageState createState() => _ParentBatchStreamPageState();
}

class _ParentBatchStreamPageState extends State<ParentBatchStreamPage> {
  @override
  void initState() {
    super.initState();
    context.read<ParentMessageBloc>().parentSetBatchId(widget.user?.batchId ?? "");
    BlocProvider.of<ParentMessageBloc>(context).add(ParentLoadMessagesEvent(batchId: widget.user?.batchId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  DeptDrawer(user: widget.user, batchId: widget.user?.batchId,),
      appBar: AppBar(
        title: const Text("Parent Announcements"),
        centerTitle: true,
      ),
      body: BlocBuilder<ParentMessageBloc, ParentMessagesState>(
        builder: (context, state) {
          if (state is ParentMessageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (state is ParentMessageLoadedState) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final announcementMessage = state.messages[index];
                      return ParentMessageTile(
                        title: announcementMessage.title,
                        date: announcementMessage.timestamp,
                        editedDate: announcementMessage.editedTimestamp,
                        content: announcementMessage.content,
                        id: announcementMessage.id,
                        batchId: widget.batchId,
                        sender: announcementMessage.sender,
                        onTap: () {
                          BlocProvider.of<ParentMessageDetailsBloc>(context).add(
                            ParentMessageDetailsInitialEvent(
                              id: announcementMessage.id,
                              title: announcementMessage.title,
                              content: announcementMessage.content,
                              sender: announcementMessage.sender,
                              toWhom: announcementMessage.toWhom,
                              fileInfo: announcementMessage.fileInfo,
                              timestamp: DateToDisplayFormat().formattedDate(
                                announcementMessage.timestamp,
                                announcementMessage.editedTimestamp,
                              ),
                              batchId: widget.batchId,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParentMessageDetailsPage(
                                messageID: announcementMessage.id,
                              ),
                            ),
                          );
                        },
                        attachmentFiles: announcementMessage.fileInfo,
                        toWhom: announcementMessage.toWhom,
                      );
                    },
                    childCount: state.messages.length,
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('No messages available'),
          );
        },
      ),
    );
  }
}
