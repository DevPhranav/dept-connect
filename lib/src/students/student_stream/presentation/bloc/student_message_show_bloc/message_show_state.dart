// message_state.dart


import '../../../domain/entites/studentAnnouncementMessage.dart';

abstract class StudentMessagesState {}

class StudentMessageInitialState extends StudentMessagesState {}

class StudentMessageLoadingState extends StudentMessagesState {}

class StudentMessageLoadedState extends StudentMessagesState {
  final List<StudentAnnouncementMessage> messages;

  StudentMessageLoadedState(this.messages);
}

class StudentMessageErrorState extends StudentMessagesState {
  final String error;

  StudentMessageErrorState(this.error);
}
