// message_event.dart

import '../../../domain/entites/studentAnnouncementMessage.dart';

abstract class StudentMessageEvent {}

class StudentLoadMessagesEvent extends StudentMessageEvent {
  final String? batchId;

  StudentLoadMessagesEvent({required this.batchId});
}

class LoadMessageInitialEvent extends StudentMessageEvent{
  final String batchId;

  LoadMessageInitialEvent({required this.batchId});

}

class UpdateMessagesEvent extends StudentMessageEvent {
  final List<StudentAnnouncementMessage> messages;

  UpdateMessagesEvent(this.messages);
}
