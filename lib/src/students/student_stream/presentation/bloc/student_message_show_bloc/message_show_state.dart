// message_state.dart


import '../../../domain/entites/studentAnnouncementMessage.dart';

abstract class StudentMessagesState {}

class MessageInitialState extends StudentMessagesState {}

class MessageLoadingState extends StudentMessagesState {}

class MessageLoadedState extends StudentMessagesState {
  final List<StudentAnnouncementMessage> messages;

  MessageLoadedState(this.messages);
}

class MessageErrorState extends StudentMessagesState {
  final String error;

  MessageErrorState(this.error);
}
