import 'package:equatable/equatable.dart';

abstract class FacultyFileDownloadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FacultyStartDownloadEvent extends FacultyFileDownloadEvent {
  final String url;
  final String fileName;
  final int index;
  final String id;

  FacultyStartDownloadEvent({
    required this.url,
    required this.fileName,
    required this.index,
    required this.id,
  });

  @override
  List<Object> get props => [url, fileName, index, id];
}

class FacultyCheckFileExistenceEvent extends FacultyFileDownloadEvent {
  final String fileName;
  final int index;
  final String id;

  FacultyCheckFileExistenceEvent({
    required this.fileName,
    required this.index,
    required this.id,
  });

  @override
  List<Object> get props => [fileName, index, id];
}
