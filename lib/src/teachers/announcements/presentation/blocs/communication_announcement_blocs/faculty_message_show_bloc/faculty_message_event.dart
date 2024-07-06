// message_event.dart


import '../../../../../../authentication/auth/data/models/auth_user_model.dart';
import '../../../../domain/entities/facultyAnnouncementMessage.dart';

abstract class FacultyMessageEvent {}

class FacultyLoadMessagesEvent extends FacultyMessageEvent {
  final AuthUserModel? user;

  FacultyLoadMessagesEvent({required this.user});
}

class FacultyLoadMessageInitialEvent extends FacultyMessageEvent{
  final String batchId;

  FacultyLoadMessageInitialEvent({required this.batchId});

}

class FacultyUpdateMessagesEvent extends FacultyMessageEvent {
  final List<FacultyAnnouncementMessage> messages;

  FacultyUpdateMessagesEvent(this.messages);
}
