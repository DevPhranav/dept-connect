import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../../static/file_icon_choose.dart';
import '../bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import '../bloc/announcement_page_blocs/file_upload_bloc/file_upload_event.dart';
import '../bloc/announcement_page_blocs/file_upload_bloc/file_upload_state.dart';

class FileUploadButton {
  Widget buildFileUploadButton(BuildContext context) {
    return BlocConsumer<FilePickBloc, FilePickState>(
      listener: (context, state) {
        if (state is FilePickFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File Upload Failed: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        List<File> files = [];
        if (state is FilePickSuccessState || state is FileEditInitialState) {
          files = state.pickedFiles;
        }
        if(state is FileRemovedSuccessState)
          {
            print(state.modifiedFiles);
            files=state.modifiedFiles;
          }
        if (state is FileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is FileLoadedState)
          {
            files = state.pickedFiles;
          }
          return GestureDetector(
            onTap: () {
              BlocProvider.of<FilePickBloc>(context).add(FilePickFilesEvent());
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(Icons.attach_file),
                            SizedBox(width: 14),
                            Text(
                              "Add Attachment",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (state is FileLoadedState || state is FileRemovedSuccessState ||state is FilePickSuccessState)
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Attachments:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: files.map((file) => _buildFileContainer(context, file)).toList(),
                        ),
                      ],
                    ),
                  )

              ],
            ),
          );

      },
    );
  }

  Widget _buildFileContainer(BuildContext context, File file) {
    String fileName = file.path.split('/').last;
    String fileExtension = fileName.split('.').last;
    String iconData = FileIconChoose().getIcon(fileExtension);

    return Container(
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                fileName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              BlocProvider.of<FilePickBloc>(context).add(RemoveFileEvent(file: file));
            },
          ),
        ],
      ),
    );
  }
}
