import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import '../../../../../../../static/file_download.dart';
import 'package:path_provider/path_provider.dart';

import 'faculty_file_download_event.dart';
import 'faculty_file_download_state.dart';

class FacultyFileDownloadBloc extends Bloc<FacultyFileDownloadEvent, FacultyFileDownloadState> {
  final List<int> allReadyDownloadedFilesIndices = [];

  FacultyFileDownloadBloc() : super(FacultyFileDownloadInitialState()) {
    on<FacultyStartDownloadEvent>(_startDownload);
    on<FacultyCheckFileExistenceEvent>(_checkFileExistence);
  }

  void _startDownload(FacultyStartDownloadEvent event, Emitter<FacultyFileDownloadState> emit) async {
    if (allReadyDownloadedFilesIndices.contains(event.index)) {
      return; // If file is already downloaded, do nothing.
    }

    emit(FacultyFileDownloadingState(currentIndex: event.index));

    try {
      final filePath = await downloadFile(event.url, event.fileName, event.id);
      emit(FacultyFileDownloadCompletedState(filePath, event.index));

      Fluttertoast.showToast(
        msg: "Download completed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      allReadyDownloadedFilesIndices.add(event.index);
      OpenFile.open(filePath);
    } catch (e) {
      emit(FacultyFileDownloadFailureState(errorMessage: "Unable to access external storage"));
      Fluttertoast.showToast(
        msg: "Download failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _checkFileExistence(FacultyCheckFileExistenceEvent event, Emitter<FacultyFileDownloadState> emit) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/${event.id}/${event.fileName}';
    final file = File(filePath);
    final fileExists = file.existsSync();

    emit(FacultyFileExistenceCheckedState(fileExists: fileExists, filePath: filePath, index: event.index));
  }
}
