
// Events
abstract class StudentMessageDetailsEvent {}

class StudentMessageDetailsInitialEvent extends StudentMessageDetailsEvent{
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;
  final String batchId;

  StudentMessageDetailsInitialEvent({required this.id, required this.title, required this.content, required this.sender, required this.toWhom, required this.fileInfo, required this.timestamp, required this.batchId});
}
class EditSuccessMessageEvent extends StudentMessageDetailsEvent {
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;
  final String batchId;

  EditSuccessMessageEvent({required this.id, required this.title, required this.content, required this.sender, required this.toWhom, required this.fileInfo, required this.timestamp, required this.batchId});


}
