import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import '../../../../../../../../../../../../static/file_download.dart';
import 'file_download_event.dart';
import 'file_download_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileDownloadBloc extends Bloc<FileDownloadEvent, FileDownloadState> {
   final allReadyDownloadedFilesIndices =[];

  FileDownloadBloc() : super(FileDownloadInitialState()) {
    on<StartDownloadEvent>(_startDownload);
  }

  void _startDownload(
      StartDownloadEvent event, Emitter<FileDownloadState> emit) async {
    if (allReadyDownloadedFilesIndices.contains(event.index)) {
      return; // If file is already downloaded, do nothing.
    }

    emit(FileDownloadingState(currentIndex: event.index));

    try {
      final filePath = await downloadFile(event.url, event.fileName, event.id);
      emit(FileDownloadCompletedState(filePath, event.index));
      Fluttertoast.showToast(
        msg: "Download completed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      allReadyDownloadedFilesIndices.add(event.index);
      OpenFile.open(filePath);
    } catch (e) {
      emit(const FileDownloadFailureState(
          errorMessage: "Unable to access external storage"));
      Fluttertoast.showToast(
        msg: "Download failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
