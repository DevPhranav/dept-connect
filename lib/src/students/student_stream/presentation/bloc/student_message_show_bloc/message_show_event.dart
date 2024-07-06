// message_event.dart

import '../../../domain/entites/studentAnnouncementMessage.dart';

abstract class StudentMessageEvent {}

class StudentLoadMessagesEvent extends StudentMessageEvent {
  final String? batchId;

  StudentLoadMessagesEvent({required this.batchId});
}

class StudentLoadMessageInitialEvent extends StudentMessageEvent{
  final String batchId;

  StudentLoadMessageInitialEvent({required this.batchId});

}

class StudentUpdateMessagesEvent extends StudentMessageEvent {
  final List<StudentAnnouncementMessage> messages;

  StudentUpdateMessagesEvent(this.messages);
}
