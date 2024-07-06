// States
abstract class StudentMessageDetailsState {}

class StudentMessageDetailsInitial extends StudentMessageDetailsState {
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;
  final String batchId;

  StudentMessageDetailsInitial(
      {required this.id,
      required this.title,
      required this.content,
      required this.sender,
      required this.toWhom,
      required this.fileInfo,
      required this.timestamp,
      required this.batchId});
}

class StudentMessageEditingState extends StudentMessageDetailsState {}
