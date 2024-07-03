// message_state.dart


import '../../../../domain/entities/announcementMessage.dart';

abstract class MessagesState {}

class MessageInitialState extends MessagesState {}

class MessageLoadingState extends MessagesState {}

class MessageLoadedState extends MessagesState {
  final List<AnnouncementMessage> messages;

  MessageLoadedState(this.messages);
}

class MessageErrorState extends MessagesState {
  final String error;

  MessageErrorState(this.error);
}
