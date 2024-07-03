import 'dart:io';

abstract class FilePickEvent {}

class FilePickFilesEvent extends FilePickEvent {}

class FilePickInitialEvent extends FilePickEvent {}

class RemoveFileEvent extends FilePickEvent {
  final File file;

  RemoveFileEvent({required this.file});
}

class FileEditInitialEvent extends FilePickEvent{
  final List<Map<String, dynamic>> attachmentFiles;

  FileEditInitialEvent({required this.attachmentFiles});
}
