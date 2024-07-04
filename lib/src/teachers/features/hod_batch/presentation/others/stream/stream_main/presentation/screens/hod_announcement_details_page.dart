import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import '../../../../../../../../../../static/empty_checkbox_container.dart';
import '../../../../../../../../../../static/file_diplay_name.dart';
import '../../../../../../../../../../static/file_download.dart';
import '../../../../../../../../../../static/file_icon_choose.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_event.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_event.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_state.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import '../../../stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_event.dart';
import '../bloc/announcement_details_full_screen_blocs/ToWhomCubit/to_whom_cubit.dart';
import '../bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_bloc.dart';
import '../bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_event.dart';
import '../bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_state.dart';
import '../bloc/announcement_details_full_screen_blocs/message_details_page_main_bloc/message_details_page_bloc.dart';
import '../bloc/announcement_details_full_screen_blocs/message_details_page_main_bloc/message_details_page_event.dart';
import '../bloc/announcement_details_full_screen_blocs/message_details_page_main_bloc/message_details_page_state.dart';
import '../bloc/stream_page_blocs/message_remove_bloc/message_remove_bloc.dart';
import '../bloc/stream_page_blocs/message_remove_bloc/message_remove_event.dart';
import 'package:path_provider/path_provider.dart';

class MessageDetailsPage extends StatelessWidget {
  final String messageID;
  const MessageDetailsPage({super.key, required this.messageID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
      builder: (context, state) {
        if (state is AnnouncementUpdateSuccessState) {
          BlocProvider.of<MessageDetailsBloc>(context).add(
              EditSuccessMessageEvent(
                  id: state.id,
                  title: state.title,
                  content: state.content,
                  sender: state.sender,
                  toWhom: state.toWhom,
                  fileInfo: state.fileInfo,
                  timestamp: state.timestamp,
                  batchId: state.batchId));
        }

        return BlocBuilder<MessageDetailsBloc, MessageDetailsInitial>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  _buildContent(context, state),
                  BlocBuilder<ToWhomOverlayCubit, bool>(
                    builder: (context, showOverlay) {
                      if (showOverlay) {
                        return _buildToWhomOverlay(context, state);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, MessageDetailsInitial state) {
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
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(''),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ToWhomOverlayCubit>().showOverlay();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(8),
                child: const Row(
                  children: [
                    Text(
                      ' To Whom',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                popupMenuTheme: const PopupMenuThemeData(),
              ),
              child: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: "edit",
                    child: Container(
                      width: 200,
                      child: Text("Edit"),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: "delete",
                    child: Container(
                      width: 200,
                      child: Text("Delete"),
                    ),
                  ),
                ],
                onSelected: (String value) {
                  if (value == "edit") {
                    BlocProvider.of<FilePickBloc>(context).add(
                        FileEditInitialEvent(attachmentFiles: state.fileInfo));
                    BlocProvider.of<AnnouncementBloc>(context)
                        .add(DetailsPageEditEvent(isDetailsPageEdit: true));
                    BlocProvider.of<AnnouncementBloc>(context).add(
                        AnnouncementEditEvent(
                            announcementMessage: state.content,
                            titleMessage: state.title,
                            id: state.id,
                            batchId: state.batchId));

                    List<Map<String, dynamic>> previousCheckBoxes =
                        List<Map<String, dynamic>>.from(checkBoxes);
                    bool checkForAll = state.toWhom.contains("all");

                    if (checkForAll) {
                      previousCheckBoxes[0]["isChecked"] = true;
                    }
                    // Process state.toWhom to set initial checkboxes
                    for (dynamic recipient in state.toWhom) {
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

                    // Set areStudentsChecked and areParentsChecked based on state.toWhom
                    bool areTeachersChecked = state.toWhom.contains("teachers");
                    bool areStudentsChecked = state.toWhom.contains("students");
                    bool areParentsChecked = state.toWhom.contains("parents");
                    bool isAllChecked = state.toWhom.contains("all");

                    BlocProvider.of<CheckBoxBloc>(context).add(
                      CheckBoxEditInitialEvent(
                        previousCheckBoxes: previousCheckBoxes,
                        areParentsChecked: areParentsChecked,
                        areStudentsChecked: areStudentsChecked,
                        areTeachersChecked: areTeachersChecked,
                        isAllChecked: isAllChecked,
                      ),
                    );
                    Navigator.pushNamed(context, "/hod_batch_announcement_page",
                        arguments: state.batchId);
                    print("Edit tapped");
                  } else if (value == "delete") {
                    _showDeleteConfirmationDialog(context, state);
                  }
                },
                icon: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        'lib/assets/icons/document.png',
                        width: 32,
                        height: 32,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            state.timestamp,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 13),
                Text(
                  state.content,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 13),
                const Text(
                  'Attachments:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: BlocBuilder<FileDownloadBloc, FileDownloadState>(
                    builder: (context, states) {
                      return ListView.builder(
                        itemCount: state.fileInfo.length,
                        itemBuilder: (context, index) {
                          final file = state.fileInfo[index];
                          final fileName = file['fileName'] ?? 'Unknown';
                          final extension = fileName.split('.').last;
                          final iconData = FileIconChoose().getIcon(extension);
                          final downloadUrl = file['downloadUrl'] ??
                              'https://via.placeholder.com/150';

                          return GestureDetector(
                            onTap: () async {
                              final filePath='${FileStorage.getExternalDocumentPath()}/$messageID/$fileName';
                              final file = File(filePath);
                              final fileExists = file.existsSync();
                              if (fileExists) {
                                OpenFile.open(filePath);
                              } else {
                                Fluttertoast.showToast(
                                  msg: "File does not exist",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              }
                            },
                            child: Container(
                              width: 320.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'lib/assets/icons/$iconData.png',
                                      width: 22,
                                      height: 22,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: fileName.length > 15
                                                ? FileNameDisplay(
                                                    fileName: fileName,
                                                    maxWidth: 200,
                                                  )
                                                : Text(
                                                    fileName,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<FileDownloadBloc>(
                                                      context)
                                                  .add(
                                                StartDownloadEvent(
                                                  url: downloadUrl,
                                                  fileName: fileName,
                                                  index: index,
                                                  id: state.id,
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: _buildDownloadIcon(
                                                  states, index, state,context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadIcon(
      FileDownloadState states, int index, MessageDetailsInitial state, BuildContext context) {
    final fileInfo = state.fileInfo[index];
    final fileName = fileInfo['fileName'] ?? 'Unknown';
    final id = state.id; // Assuming state.id represents the message ID

    final downloadUrl = fileInfo['downloadUrl'] ?? 'https://via.placeholder.com/150';

    return FutureBuilder<String>(
      future: getPath(fileName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator or a placeholder widget
          return CircularProgressIndicator(color: Colors.black);
        } else if (snapshot.hasError) {
          // If there's an error fetching the file path, handle it here
          return Icon(Icons.error, color: Colors.red); // Placeholder for error handling
        } else {
          final file = File(snapshot.data!);
          final fileExists = file.existsSync();

          if (fileExists) {
            return GestureDetector(
              onTap: () {
                OpenFile.open(snapshot.data!);
              },
              child: Icon(Icons.check_circle, color: Colors.green, size: 23),
            );
          } else {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<FileDownloadBloc>(context).add(
                  StartDownloadEvent(
                    url: downloadUrl,
                    fileName: fileName,
                    index: index,
                    id: id,
                  ),
                );
              },
              child: Icon(Icons.download, color: Colors.black, size: 23),
            );
          }
        }
      },
    );
  }

  Future<String> getPath(String fileName) async {
    final directory = await getExternalStorageDirectory();
    final newDirectory = Directory('${directory?.path}/$messageID');
    final filePath = '${newDirectory.path}/$fileName';
    return filePath;
  }

  Widget _buildToWhomOverlay(
      BuildContext context, MessageDetailsInitial state) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            width: 320,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ToWhomOverlayCubit>(context)
                            .hideOverlay();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Text(
                          'To Whom',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                EmptyCheckBoxContainer(checkedBoxes: state.toWhom)
                    .buildCheckBoxes(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, MessageDetailsInitial state) {
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
                BlocProvider.of<MessageRemoveBloc>(context)
                    .add(RemoveMessageEvent(
                  id: state.id,
                  fileInfo: state.fileInfo,
                  batchId: state.batchId,
                ));
                Navigator.pop(context);
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
