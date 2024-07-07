// States
abstract class ParentMessageDetailsState {}

class ParentMessageDetailsInitial extends ParentMessageDetailsState {
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;
  final String batchId;

  ParentMessageDetailsInitial(
      {required this.id,
      required this.title,
      required this.content,
      required this.sender,
      required this.toWhom,
      required this.fileInfo,
      required this.timestamp,
      required this.batchId});
}

class ParentMessageEditingState extends ParentMessageDetailsState {}
