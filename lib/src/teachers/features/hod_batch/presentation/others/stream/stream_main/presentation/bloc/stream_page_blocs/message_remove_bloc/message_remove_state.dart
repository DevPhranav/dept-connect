

// States
abstract class MessageRemoveState {}

class MessageRemoveInitial extends MessageRemoveState {}

class MessageRemoveInProgress extends MessageRemoveState {}

class MessageRemoveSuccess extends MessageRemoveState {}

class MessageRemoveFailure extends MessageRemoveState {
  final String error;

  MessageRemoveFailure({required this.error});
}