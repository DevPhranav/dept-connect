import 'package:equatable/equatable.dart';

abstract class ParentFileDownloadEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ParentStartDownloadEvent extends ParentFileDownloadEvent {
  final String url;
  final String fileName;
  final int index;
  final String id;

  ParentStartDownloadEvent({
    required this.url,
    required this.fileName,
    required this.index,
    required this.id,
  });

  @override
  List<Object> get props => [url, fileName, index, id];
}

class ParentCheckFileExistenceEvent extends ParentFileDownloadEvent {
  final String fileName;
  final int index;
  final String id;

  ParentCheckFileExistenceEvent({
    required this.fileName,
    required this.index,
    required this.id,
  });

  @override
  List<Object> get props => [fileName, index, id];
}
