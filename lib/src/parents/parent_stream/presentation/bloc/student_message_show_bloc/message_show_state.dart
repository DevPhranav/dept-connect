// message_state.dart

import '../../../../../students/student_stream/domain/entites/studentAnnouncementMessage.dart';
import '../../../domain/entites/parentAnnouncementMessage.dart';

abstract class ParentMessagesState {}

class ParentMessageInitialState extends ParentMessagesState {}

class ParentMessageLoadingState extends ParentMessagesState {}

class ParentMessageLoadedState extends ParentMessagesState {
  final List<ParentAnnouncementMessage> messages;

  ParentMessageLoadedState(this.messages);
}

class ParentMessageErrorState extends ParentMessagesState {
  final String error;

  ParentMessageErrorState(this.error);
}
