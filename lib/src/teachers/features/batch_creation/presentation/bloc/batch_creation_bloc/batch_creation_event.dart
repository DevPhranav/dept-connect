import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class BatchCreationEvent extends Equatable {
  const BatchCreationEvent();

  @override
  List<Object?> get props => [];
}

class ProcessBatchValidation extends BatchCreationEvent {
  final String batchYear;
  final String seniorTutor;
  final FilePickerResult? selectedFile;

  const ProcessBatchValidation(
      {required this.batchYear,
      required this.seniorTutor,
      required this.selectedFile});
}

class StartBatchCreationProcess extends BatchCreationEvent{
  final FilePickerResult? selectedFile;
  final String batchYear;
  final String seniorTutorId;

  const StartBatchCreationProcess({ required this.batchYear, required this.seniorTutorId, required this.selectedFile});
}


