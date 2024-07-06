// BLoC
import 'package:flutter_bloc/flutter_bloc.dart';

import 'faculty_message_details_event.dart';
import 'faculty_message_details_state.dart';

class FacultyMessageDetailsBloc
    extends Bloc<FacultyMessageDetailsEvent, FacultyMessageDetailsState> {
  FacultyMessageDetailsBloc()
      : super(FacultyMessageDetailsInitial(
      id: '',
      title: '',
      content: '',
      sender: '',
      toWhom: [],
      fileInfo: [],
      timestamp: '',)) {
    on<FacultyMessageDetailsInitialEvent>(_detailsPageInitial);
  }

  void _detailsPageInitial(FacultyMessageDetailsInitialEvent event, emit) {
    print(event.timestamp);
    emit(FacultyMessageDetailsInitial(
        id: event.id,
        title: event.title,
        content: event.content,
        sender: event.sender,
        toWhom: event.toWhom,
        fileInfo: event.fileInfo,
        timestamp: event.timestamp,
    ));
  }




}