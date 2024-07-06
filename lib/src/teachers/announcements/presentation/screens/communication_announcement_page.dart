import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/models/auth_user_model.dart';
import 'package:miniproject_authentication/src/students/student_stream/presentation/screens/student_message_details_page.dart';
import '../../../../../../../../../../static/date_to_display_format.dart';
import '../../widgets/faculty_message_tile.dart';
import '../blocs/communication_announcement_blocs/faculty_message_show_bloc/faculty_message_bloc.dart';
import '../blocs/communication_announcement_blocs/faculty_message_show_bloc/faculty_message_state.dart';
import '../blocs/communication_announcement_details_full_screen_blocs/faculty_message_details_page_main_bloc/faculty_message_details_bloc.dart';
import '../blocs/communication_announcement_details_full_screen_blocs/faculty_message_details_page_main_bloc/faculty_message_details_event.dart';
import 'communication_announcement_details_page.dart';

class CommunicationAnnouncementStreamPage extends StatelessWidget {
  final AuthUserModel? user;

  const CommunicationAnnouncementStreamPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Batch Stream"),
        centerTitle: true,
      ),
      body: BlocBuilder<FacultyMessageBloc, FacultyMessagesState>(
        builder: (context, state) {
          if (state is FacultyMessageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (state is FacultyMessageLoadedState) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final announcementMessage = state.messages[index];
                      return FacultyMessageTile(
                        title: announcementMessage.title,
                        date: announcementMessage.timestamp,
                        editedDate: announcementMessage.editedTimestamp,
                        content: announcementMessage.content,
                        id: announcementMessage.id,
                        sender: announcementMessage.sender,
                        onTap: () {
                          BlocProvider.of<FacultyMessageDetailsBloc>(context).add(
                            FacultyMessageDetailsInitialEvent(
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
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FacultyMessageDetailsPage(
                                messageID: announcementMessage.id
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
