import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/models/auth_user_model.dart';
import '../../../../../../../../../static/date_to_display_format.dart';
import '../../../../../../../../../static/file_icon_choose.dart';
import '../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import '../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_event.dart';
import '../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import '../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import '../../stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import '../../stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_event.dart';
import '../../stream_announcement/presentation/screens/hod_batch_announcement_page.dart';
import '../presentation/bloc/stream_page_blocs/message_remove_bloc/message_remove_bloc.dart';
import '../presentation/bloc/stream_page_blocs/message_remove_bloc/message_remove_event.dart';

class MessageTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final String content;
  final List<Map<String, dynamic>> attachmentFiles;
  final List<dynamic> toWhom;
  final VoidCallback onTap;
  final String id;
  final DateTime editedDate;
  final String batchId;
  final AuthUserModel? user;

  const MessageTile({
    super.key,
    required this.title,
    required this.date,
    required this.content,
    required this.attachmentFiles,
    required this.onTap,
    required this.id,
    required this.toWhom, required this.editedDate,required this.batchId, this.user,
  });

  @override
  Widget build(BuildContext context) {
    final checkBoxes = [
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
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Material(
        color: Colors.grey[200],
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[50],
                            child: const Icon(Icons.message),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              truncateFileName(title,15),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                          DateToDisplayFormat().formattedDate(date, editedDate),
                              // Change this to your date formatting logic
                              style: const TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _truncateContent(content, 15),
                    ),
                    const SizedBox(height: 20),
                    _buildAttachmentFiles(),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    popupMenuTheme: const PopupMenuThemeData(),
                  ),
                  child: PopupMenuButton<String>(
                    itemBuilder: (context) =>
                    [
                      PopupMenuItem<String>(
                        value: "edit",
                        child: Container(
                          child: Text("Edit"),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: "Share",
                        child: Container(
                          child: Text("Share"),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: "delete",
                        child: Container(
                          child: Text("Delete"),
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      if(value == "Share"){

                      }

                      if (value == "edit") {
                        BlocProvider.of<FilePickBloc>(context).add(FileEditInitialEvent(attachmentFiles: attachmentFiles));
                          BlocProvider.of<AnnouncementBloc>(context).add(AnnouncementEditEvent(announcementMessage: content, titleMessage: title,id: id, batchId:batchId));
                        List<Map<String, dynamic>> previousCheckBoxes =
                        List<Map<String, dynamic>>.from(checkBoxes);
                        bool checkForAll = toWhom.contains("all");

                        if (checkForAll) {
                          previousCheckBoxes[0]["isChecked"] = true;
                        }
                        // Process toWhom to set initial checkboxes
                        for (dynamic recipient in toWhom) {
                          switch (recipient) {
                            case "teachers":
                              previousCheckBoxes[1]["isChecked"] = true;
                              break;
                            case "tSec1":
                              previousCheckBoxes[2]["isChecked"] = true;
                              break;
                            case "tSec2":
                              previousCheckBoxes[3]["isChecked"] = true;
                              break;
                            case "students":
                              previousCheckBoxes[4]["isChecked"] = true;
                              break;
                            case "sSec1":
                              previousCheckBoxes[5]["isChecked"] = true;
                              break;
                            case "sSec2":
                              previousCheckBoxes[6]["isChecked"] = true;
                              break;
                            case "parents":
                              previousCheckBoxes[7]["isChecked"] = true;
                              break;
                            case "pSec1":
                              previousCheckBoxes[8]["isChecked"] = true;
                              break;
                            case "pSec2":
                              previousCheckBoxes[9]["isChecked"] = true;
                              break;
                            case "seniorTutor":
                              previousCheckBoxes[10]["isChecked"] = true;
                              break;
                          }
                        }


                        // Set areStudentsChecked and areParentsChecked based on toWhom
                        bool areTeachersChecked = toWhom.contains("teachers");
                        bool areStudentsChecked = toWhom.contains("students");
                        bool areParentsChecked = toWhom.contains("parents");
                        bool isAllChecked = toWhom.contains("all");


                        BlocProvider.of<CheckBoxBloc>(context).add(
                            CheckBoxEditInitialEvent(
                                previousCheckBoxes: previousCheckBoxes,
                                areParentsChecked: areParentsChecked,
                                areStudentsChecked: areStudentsChecked,
                                areTeachersChecked: areTeachersChecked,
                                isAllChecked: isAllChecked,
                        ),

                      );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HodBatchAnnouncementPage(batchId: batchId,user:user),
                          ),
                        );


                      } else if (value == "delete") {
                      // Handle delete action
                        _showDeleteConfirmationDialog(context,id,batchId);
                      }
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateContent(String content, int maxLength) {
    if (content.length <= maxLength) {
      return content;
    }

    int nextSpaceIndex = content.indexOf(' ', maxLength);
    if (nextSpaceIndex != -1) {
      return '${content.substring(0, nextSpaceIndex)}...';
    }

    return '${content.substring(0, maxLength)}...';
  }

  Widget _buildAttachmentFiles() {
    if (attachmentFiles.isEmpty) {
      return Container();
    }

    List<Widget> attachmentWidgets = [];
    for (int i = 0; i < attachmentFiles.length && i < 2; i++) {
      attachmentWidgets
          .add(_buildAttachmentWidget(attachmentFiles[i]['fileName']));
    }

    if (attachmentFiles.length > 2) {
      attachmentWidgets.add(
        Text('+${attachmentFiles.length - 2} more attachments'),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attachmentWidgets,
      ),
    );
  }

  String truncateFileName(String fileName, int maxLength) {
    int extIndex = fileName.lastIndexOf('.');
    if (extIndex == -1) {
      return fileName.length > maxLength
          ? '${fileName.substring(0, maxLength)}...'
          : fileName;
    }

    String baseName = fileName.substring(0, extIndex);
    String extension = fileName.substring(extIndex);

    if (baseName.length > maxLength) {
      baseName = '${baseName.substring(0, maxLength)}...';
    }
    return baseName + extension;
  }

  Widget _buildAttachmentWidget(String fileName) {
    String extension = fileName
        .split('.')
        .last
        .toLowerCase();
    String truncatedFileName = truncateFileName(fileName, 20);

    // Use your FileIconChoose logic to get the icon based on the file extension
    String iconData = FileIconChoose().getIcon(extension);

    return Row(
      children: [
       Image.asset(
         'lib/assets/icons/$iconData.png',
         width: 24, // Set the width of the image
         height: 24, // Set the height of the image
       ),
        const SizedBox(width: 8.0),
        Text(truncatedFileName),
      ],
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context,String id,String batchId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Message"),
          content: const Text("Are you sure you want to delete this message?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                print("id : $id");
                BlocProvider.of<MessageRemoveBloc>(context).add(RemoveMessageEvent(id: id,fileInfo:attachmentFiles, batchId: batchId));
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        // Trigger the delete event

      }
    });
  }
}
