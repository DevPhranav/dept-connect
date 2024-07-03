import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'file_upload_event.dart';
import 'file_upload_state.dart';

class FilePickBloc extends Bloc<FilePickEvent, FilePickState> {
  List<File> uploadedFiles = [];

  FilePickBloc() : super(FilePickInitialState(pickedFiles: [])) {
    on<FilePickFilesEvent>(_getFiles);
    on<FilePickInitialEvent>(_callInitialState);
    on<RemoveFileEvent>(_removeFile);
    on<FileEditInitialEvent>(_callEditFileInitialState);

  }

  void _callEditFileInitialState(
      FileEditInitialEvent event, Emitter<FilePickState> emit) async {
    // Download files from URLs and create a list of File objects
    emit(FileLoadingState(pickedFiles: uploadedFiles));
    List<File> downloadedFiles = await _downloadFilesFromUrls(event.attachmentFiles);
    print("From bloc : $downloadedFiles");
    uploadedFiles = downloadedFiles;
    emit(FileEditInitialState(pickedFiles: downloadedFiles, files: downloadedFiles));
    emit(FileLoadedState(pickedFiles: downloadedFiles));
  }

  Future<List<File>> _downloadFilesFromUrls(List<Map<String, dynamic>> files) async {
    List<File> downloadedFiles = [];
    final directory = await getTemporaryDirectory();

    for (var fileInfo in files) {
      String fileName = fileInfo['fileName'];
      String url = fileInfo['downloadUrl'];

      try {
        // Download file
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          // Save file to temporary directory
          File file = File('${directory.path}/$fileName');
          await file.writeAsBytes(response.bodyBytes);
          downloadedFiles.add(file);
        } else {
          throw Exception('Failed to download file: $fileName');
        }
      } catch (e) {
        print('Error downloading file $fileName: $e');
      }
    }

    return downloadedFiles;
  }

  void _callInitialState(
      FilePickInitialEvent event, Emitter<FilePickState> emit) {
    emit(FilePickInitialState(pickedFiles: []));
    uploadedFiles = [];
  }

  void _getFiles(FilePickFilesEvent event, Emitter<FilePickState> emit) async {
    try {
      uploadedFiles = state.pickedFiles;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, // Enable multiple file selection
      );
      if (result != null) {
        for (PlatformFile file in result.files) {
          uploadedFiles.add(File(file.path!));
        }
        emit(FilePickSuccessState(pickedFiles: uploadedFiles));
      } else {
        emit(FilePickFailureState(
            message: 'File selection canceled', pickedFiles: []));
      }
    } catch (e) {
      emit(FilePickFailureState(message: e.toString(), pickedFiles: []));
    }
  }

  void _removeFile(RemoveFileEvent event, Emitter<FilePickState> emit) {
    uploadedFiles.remove(event.file);
    emit(FileRemovedSuccessState(modifiedFiles: List.from(uploadedFiles), pickedFiles: []));
  }

}
