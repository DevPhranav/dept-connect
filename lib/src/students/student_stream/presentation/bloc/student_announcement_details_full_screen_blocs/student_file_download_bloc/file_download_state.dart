import 'package:equatable/equatable.dart';

abstract class StudentFileDownloadState extends Equatable {
  @override
  List<Object> get props => [];
}

class FileDownloadInitialState extends StudentFileDownloadState {}

class FileDownloadingState extends StudentFileDownloadState {
  final int currentIndex;

  FileDownloadingState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class FileDownloadCompletedState extends StudentFileDownloadState {
  final String filePath;
  final int completedIndex;

  FileDownloadCompletedState(this.filePath, this.completedIndex);

  @override
  List<Object> get props => [filePath, completedIndex];
}

class FileDownloadFailureState extends StudentFileDownloadState {
  final String errorMessage;

  FileDownloadFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class FileExistenceCheckedState extends StudentFileDownloadState {
  final bool fileExists;
  final String filePath;
  final int index;

  FileExistenceCheckedState({
    required this.fileExists,
    required this.filePath,
    required this.index,
  });

  @override
  List<Object> get props => [fileExists, filePath, index];
}

class FileNotDownloadedState extends StudentFileDownloadState {
  final int index;

  FileNotDownloadedState({required this.index});

  @override
  List<Object> get props => [index];
}
