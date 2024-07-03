// file_download_event.dart
import 'package:equatable/equatable.dart';

abstract class FileDownloadEvent extends Equatable {
  const FileDownloadEvent();

  @override
  List<Object> get props => [];
}


class StartDownloadEvent extends FileDownloadEvent {
  final String url;
  final String fileName;
  final int index;
  final String id;

  const StartDownloadEvent({required this.url, required this.fileName, required this.index, required this.id});



  @override
  List<Object> get props => [url, fileName,index,id];
}
