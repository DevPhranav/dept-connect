import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import '../../../../../../../static/file_download.dart';
import 'file_download_event.dart';
import 'file_download_state.dart';
import 'package:path_provider/path_provider.dart';

class ParentFileDownloadBloc extends Bloc<ParentFileDownloadEvent, ParentFileDownloadState> {
  final List<int> allReadyDownloadedFilesIndices = [];

  ParentFileDownloadBloc() : super(ParentFileDownloadInitialState()) {
    on<ParentStartDownloadEvent>(_startDownload);
    on<ParentCheckFileExistenceEvent>(_checkFileExistence);
  }

  void _startDownload(ParentStartDownloadEvent event, Emitter<ParentFileDownloadState> emit) async {
    if (allReadyDownloadedFilesIndices.contains(event.index)) {
      return; // If file is already downloaded, do nothing.
    }

    emit(ParentFileDownloadingState(currentIndex: event.index));

    try {
      final filePath = await downloadFile(event.url, event.fileName, event.id);
      emit(ParentFileDownloadCompletedState(filePath, event.index));

      Fluttertoast.showToast(
        msg: "Download completed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      allReadyDownloadedFilesIndices.add(event.index);
      OpenFile.open(filePath);
    } catch (e) {
      emit(ParentFileDownloadFailureState(errorMessage: "Unable to access external storage"));
      Fluttertoast.showToast(
        msg: "Download failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _checkFileExistence(ParentCheckFileExistenceEvent event, Emitter<ParentFileDownloadState> emit) async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/${event.id}/${event.fileName}';
    final file = File(filePath);
    final fileExists = file.existsSync();

    emit(ParentFileExistenceCheckedState(fileExists: fileExists, filePath: filePath, index: event.index));
  }
}
