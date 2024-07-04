import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import '../../../../../../../../../../static/empty_checkbox_container.dart';
import '../../../../../../../../../../static/file_diplay_name.dart';
import '../../../../../../../../../../static/file_download.dart';
import '../../../../../../../../../../static/file_icon_choose.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_file_download_bloc/file_download_bloc.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_file_download_bloc/file_download_event.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_file_download_bloc/file_download_state.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_bloc.dart';
import '../bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_state.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class StudentMessageDetailsPage extends StatelessWidget {
  final String messageID;
  const StudentMessageDetailsPage({super.key, required this.messageID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentMessageDetailsBloc, StudentMessageDetailsInitial>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              _buildContent(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, StudentMessageDetailsInitial state) {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(''),
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
                  child: BlocBuilder<StudentFileDownloadBloc, StudentFileDownloadState>(
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

                              final directory = await getExternalStorageDirectory();
                              final newDirectory = Directory('${directory?.path}/$messageID');
                              final filePath = '${newDirectory.path}/$fileName';
                              print("ff $filePath");
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
                                              BlocProvider.of<StudentFileDownloadBloc>(
                                                  context)
                                                  .add(
                                                StudentStartDownloadEvent(
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
      StudentFileDownloadState states, int index, StudentMessageDetailsInitial state, BuildContext context) {
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
                BlocProvider.of<StudentFileDownloadBloc>(context).add(
                  StudentStartDownloadEvent(
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



}
