import 'package:equatable/equatable.dart';

abstract class FacultyFileDownloadState extends Equatable {
  @override
  List<Object> get props => [];
}

class FacultyFileDownloadInitialState extends FacultyFileDownloadState {}

class FacultyFileDownloadingState extends FacultyFileDownloadState {
  final int currentIndex;

  FacultyFileDownloadingState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class FacultyFileDownloadCompletedState extends FacultyFileDownloadState {
  final String filePath;
  final int completedIndex;

  FacultyFileDownloadCompletedState(this.filePath, this.completedIndex);

  @override
  List<Object> get props => [filePath, completedIndex];
}

class FacultyFileDownloadFailureState extends FacultyFileDownloadState {
  final String errorMessage;

  FacultyFileDownloadFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class FacultyFileExistenceCheckedState extends FacultyFileDownloadState {
  final bool fileExists;
  final String filePath;
  final int index;

  FacultyFileExistenceCheckedState({
    required this.fileExists,
    required this.filePath,
    required this.index,
  });

  @override
  List<Object> get props => [fileExists, filePath, index];
}

class FacultyFileNotDownloadedState extends FacultyFileDownloadState {
  final int index;

  FacultyFileNotDownloadedState({required this.index});

  @override
  List<Object> get props => [index];
}
