import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/students/student_stream/presentation/screens/student_message_details_page.dart';
import '../../../../../../../../../../static/calculate_year.dart';
import '../../../../../../../../../../static/date_to_display_format.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_bloc.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_event.dart';
import '../bloc/student_message_show_bloc/message_show_bloc.dart';
import '../bloc/student_message_show_bloc/message_show_state.dart';
import '../widgets/message_tile.dart';
import '../widgets/stream_tile.dart';

class StudentBatchStreamPage extends StatelessWidget {
  final String batchId;

  const StudentBatchStreamPage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Batch Stream"),
        centerTitle: true,
      ),
      body: BlocBuilder<StudentMessageBloc, StudentMessagesState>(
        builder: (context, state) {
          if (state is MessageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (state is MessageLoadedState) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: StudentStreamTile(
                      title: batchId,
                      subtitle: CalculateYear().getYearText(batchId)),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final announcementMessage = state.messages[index];
                      return StudentMessageTile(
                        title: announcementMessage.title,
                        date: announcementMessage.timestamp,
                        editedDate: announcementMessage.editedTimestamp,
                        content: announcementMessage.content,
                        id: announcementMessage.id,
                        batchId: batchId,
                        onTap: () {
                          BlocProvider.of<StudentMessageDetailsBloc>(context).add(
                            StudentMessageDetailsInitialEvent(
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
                              batchId: batchId,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentMessageDetailsPage(
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
