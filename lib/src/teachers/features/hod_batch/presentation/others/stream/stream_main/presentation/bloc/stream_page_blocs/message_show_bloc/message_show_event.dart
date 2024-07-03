// message_event.dart


import '../../../../domain/entities/announcementMessage.dart';

abstract class MessageEvent {}

class LoadMessagesEvent extends MessageEvent {
  final String batchId;

  LoadMessagesEvent({required this.batchId});
}

class LoadMessageInitialEvent extends MessageEvent{
  final String batchId;

  LoadMessageInitialEvent({required this.batchId});

}

class UpdateMessagesEvent extends MessageEvent {
  final List<AnnouncementMessage> messages;

  UpdateMessagesEvent(this.messages);
}
