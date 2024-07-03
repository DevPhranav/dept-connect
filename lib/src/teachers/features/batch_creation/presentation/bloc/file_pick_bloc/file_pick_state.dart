import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

abstract class FilePickerState extends Equatable {
  final FilePickerResult? selectedFile;

  const FilePickerState(this.selectedFile);

  @override
  List<Object?> get props => [selectedFile];
}

class FilePickerInitial extends FilePickerState {
  FilePickerInitial() : super(null);
}

class FilePickerLoaded extends FilePickerState {
  FilePickerLoaded(FilePickerResult? selectedFile) : super(selectedFile);
}
