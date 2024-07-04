import 'package:equatable/equatable.dart';

abstract class StudentFileDownloadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StudentStartDownloadEvent extends StudentFileDownloadEvent {
  final String url;
  final String fileName;
  final int index;
  final String id;

  StudentStartDownloadEvent({
    required this.url,
    required this.fileName,
    required this.index,
    required this.id,
  });

  @override
  List<Object> get props => [url, fileName, index, id];
}

class StudentCheckFileExistenceEvent extends StudentFileDownloadEvent {
  final String fileName;
  final int index;
  final String id;

  StudentCheckFileExistenceEvent({
    required this.fileName,
    required this.index,
    required this.id,
  });

  @override
  List<Object> get props => [fileName, index, id];
}
