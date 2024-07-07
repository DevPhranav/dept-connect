// message_event.dart



import '../../../domain/entites/parentAnnouncementMessage.dart';

abstract class ParentMessageEvent {}

class ParentLoadMessagesEvent extends ParentMessageEvent {
  final String? batchId;

  ParentLoadMessagesEvent({required this.batchId});
}

class ParentLoadMessageInitialEvent extends ParentMessageEvent{
  final String batchId;

  ParentLoadMessageInitialEvent({required this.batchId});

}

class ParentUpdateMessagesEvent extends ParentMessageEvent {
  final List<ParentAnnouncementMessage> messages;

  ParentUpdateMessagesEvent(this.messages);
}
