// message_state.dart

import '../../../../domain/entities/facultyAnnouncementMessage.dart';

abstract class FacultyMessagesState {}

class FacultyMessageInitialState extends FacultyMessagesState {}

class FacultyMessageLoadingState extends FacultyMessagesState {}

class FacultyMessageLoadedState extends FacultyMessagesState {
  final List<FacultyAnnouncementMessage> messages;

  FacultyMessageLoadedState(this.messages);
}

class FacultyMessageErrorState extends FacultyMessagesState {
  final String error;

  FacultyMessageErrorState(this.error);
}
