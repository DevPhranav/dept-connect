import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class FilePickerEvent extends Equatable {
  const FilePickerEvent();

  @override
  List<Object?> get props => [];
}

class FilePickInitialEvent extends FilePickerEvent{
}

class FileSelected extends FilePickerEvent {
  final FilePickerResult selectedFile;

  const FileSelected(this.selectedFile);

  @override
  List<Object?> get props => [selectedFile];
}

class ClearFileSelected extends FilePickerEvent {}

