

// Events
abstract class MessageRemoveEvent {}

class RemoveMessageEvent extends MessageRemoveEvent {
  final String id;
  final String batchId;
  final List<Map<String, dynamic>> fileInfo;

  RemoveMessageEvent({required this.id, required this.fileInfo,required this.batchId});


}