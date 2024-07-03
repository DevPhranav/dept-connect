// file_download_state.dart
import 'package:equatable/equatable.dart';

abstract class FileDownloadState extends Equatable {
  const FileDownloadState();

  @override
  List<Object> get props => [];
}

class FileDownloadInitialState extends FileDownloadState {}

class FileDownloadingState extends FileDownloadState {
  final int currentIndex;

  const FileDownloadingState( {required this.currentIndex});
}

class FileDownloadCompletedState extends FileDownloadState {
  final String filePath;
  final int completedIndex;

  const FileDownloadCompletedState(this.filePath,this.completedIndex);

  @override
  List<Object> get props => [filePath,completedIndex];
}


class FileDownloadFailureState extends FileDownloadState{

  final String errorMessage;

  const FileDownloadFailureState({required this.errorMessage});

}

class FileNotDownloadedState extends FileDownloadState{
  final int index;

  const FileNotDownloadedState({required this.index});
}
