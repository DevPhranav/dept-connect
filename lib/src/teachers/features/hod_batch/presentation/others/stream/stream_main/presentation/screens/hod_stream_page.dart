import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../../static/calculate_year.dart';
import '../../../../../../../../../../static/date_to_display_format.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_event.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_event.dart';
import '../../widgets/message_tile.dart';
import '../../widgets/stream_announce_tile.dart';
import '../../widgets/stream_tile.dart';
import '../bloc/announcement_details_full_screen_blocs/message_details_page_main_bloc/message_details_page_bloc.dart';
import '../bloc/announcement_details_full_screen_blocs/message_details_page_main_bloc/message_details_page_event.dart';
import '../bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
import '../bloc/stream_page_blocs/message_show_bloc/message_show_state.dart';
import 'hod_announcement_details_page.dart';

class HodBatchStreamPage extends StatelessWidget {
  final String batchId;

  const HodBatchStreamPage({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    final initialCheckBoxes = [
      {"name": "all", "isChecked": false},
      {"name": "teachers", "isChecked": false},
      {"name": "tSec1", "isChecked": false},
      {"name": "tSec2", "isChecked": false},
      {"name": "students", "isChecked": false},
      {"name": "sSec1", "isChecked": false},
      {"name": "sSec2", "isChecked": false},
      {"name": "parents", "isChecked": false},
      {"name": "pSec1", "isChecked": false},
      {"name": "pSec2", "isChecked": false},
      {"name": "seniorTutor", "isChecked": false}
    ];

    return BlocBuilder<MessageBloc, MessagesState>(
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
                child: StreamTile(
                    title: batchId,
                    subtitle: CalculateYear().getYearText(batchId)),
              ),
              SliverToBoxAdapter(
                child: StreamAnnounceTile(
                  title: "Announce Something to your batch",
                  onTap: () {
                    BlocProvider.of<CheckBoxBloc>(context)
                        .add(CheckBoxInitialEvent(
                      checkboxes: initialCheckBoxes,
                    ));
                    BlocProvider.of<AnnouncementBloc>(context)
                        .add(AnnouncementInitialEvent());
                    BlocProvider.of<FilePickBloc>(context)
                        .add(FilePickInitialEvent());
                    Navigator.pushNamed(context, "/hod_batch_announcement_page",
                        arguments: batchId);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final announcementMessage = state.messages[index];
                    return MessageTile(
                      title: announcementMessage.title,
                      date: announcementMessage.timestamp,
                      editedDate: announcementMessage.editedTimestamp,
                      content: announcementMessage.content,
                      id: announcementMessage.id,
                      batchId: batchId,
                      onTap: () {

                        BlocProvider.of<MessageDetailsBloc>(context).add(
                            MessageDetailsInitialEvent(
                                id: announcementMessage.id,
                                title: announcementMessage.title,
                                content: announcementMessage.content,
                                sender: announcementMessage.sender,
                                toWhom: announcementMessage.toWhom,
                                fileInfo: announcementMessage.fileInfo,
                                timestamp: DateToDisplayFormat().formattedDate(announcementMessage.timestamp, announcementMessage.editedTimestamp),
                                batchId: batchId));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageDetailsPage(),
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
    );
  }
}
