import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'file_pick_event.dart';
import 'file_pick_state.dart';

class BatchCreationFilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  BatchCreationFilePickerBloc() : super(FilePickerInitial()) {
    on<FilePickInitialEvent>(_onInitial);
    on<FileSelected>(_onFileSelected);
    on<ClearFileSelected>(_onClearFileSelected);
  }

  void _onInitial(event,emit)
  {
    emit(FilePickerInitial());
  }



  void _onFileSelected(FileSelected event, Emitter<FilePickerState> emit) {
    emit(FilePickerLoaded(event.selectedFile));
  }

  void _onClearFileSelected(ClearFileSelected event, Emitter<FilePickerState> emit) {
    emit(FilePickerInitial());
  }
}
