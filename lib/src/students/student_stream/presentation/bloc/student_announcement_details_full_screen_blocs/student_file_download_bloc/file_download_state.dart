import 'package:equatable/equatable.dart';

abstract class StudentFileDownloadState extends Equatable {
  @override
  List<Object> get props => [];
}

class StudentFileDownloadInitialState extends StudentFileDownloadState {}

class StudentFileDownloadingState extends StudentFileDownloadState {
  final int currentIndex;

  StudentFileDownloadingState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class StudentFileDownloadCompletedState extends StudentFileDownloadState {
  final String filePath;
  final int completedIndex;

  StudentFileDownloadCompletedState(this.filePath, this.completedIndex);

  @override
  List<Object> get props => [filePath, completedIndex];
}

class StudentFileDownloadFailureState extends StudentFileDownloadState {
  final String errorMessage;

  StudentFileDownloadFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class StudentFileExistenceCheckedState extends StudentFileDownloadState {
  final bool fileExists;
  final String filePath;
  final int index;

  StudentFileExistenceCheckedState({
    required this.fileExists,
    required this.filePath,
    required this.index,
  });

  @override
  List<Object> get props => [fileExists, filePath, index];
}

class StudentFileNotDownloadedState extends StudentFileDownloadState {
  final int index;

  StudentFileNotDownloadedState({required this.index});

  @override
  List<Object> get props => [index];
}
