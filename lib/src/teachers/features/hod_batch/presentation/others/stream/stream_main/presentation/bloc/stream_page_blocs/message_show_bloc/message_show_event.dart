// message_event.dart


import '../../../../../../../../../../../authentication/auth/data/models/auth_user_model.dart';
import '../../../../domain/entities/announcementMessage.dart';

abstract class MessageEvent {}

class LoadMessagesEvent extends MessageEvent {
  final String batchId;
  final AuthUserModel? user;

  LoadMessagesEvent({required this.batchId,required this.user});
}

class LoadMessageInitialEvent extends MessageEvent{
  final String batchId;

  LoadMessageInitialEvent({required this.batchId});

}

class UpdateMessagesEvent extends MessageEvent {
  final List<AnnouncementMessage> messages;

  UpdateMessagesEvent(this.messages);
}
