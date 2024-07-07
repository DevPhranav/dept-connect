import 'package:equatable/equatable.dart';

abstract class ParentFileDownloadState extends Equatable {
  @override
  List<Object> get props => [];
}

class ParentFileDownloadInitialState extends ParentFileDownloadState {}

class ParentFileDownloadingState extends ParentFileDownloadState {
  final int currentIndex;

  ParentFileDownloadingState({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];
}

class ParentFileDownloadCompletedState extends ParentFileDownloadState {
  final String filePath;
  final int completedIndex;

  ParentFileDownloadCompletedState(this.filePath, this.completedIndex);

  @override
  List<Object> get props => [filePath, completedIndex];
}

class ParentFileDownloadFailureState extends ParentFileDownloadState {
  final String errorMessage;

  ParentFileDownloadFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ParentFileExistenceCheckedState extends ParentFileDownloadState {
  final bool fileExists;
  final String filePath;
  final int index;

  ParentFileExistenceCheckedState({
    required this.fileExists,
    required this.filePath,
    required this.index,
  });

  @override
  List<Object> get props => [fileExists, filePath, index];
}

class ParentFileNotDownloadedState extends ParentFileDownloadState {
  final int index;

  ParentFileNotDownloadedState({required this.index});

  @override
  List<Object> get props => [index];
}
