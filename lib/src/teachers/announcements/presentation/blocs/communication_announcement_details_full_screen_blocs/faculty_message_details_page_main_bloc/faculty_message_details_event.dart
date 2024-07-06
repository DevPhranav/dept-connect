
// Events
abstract class FacultyMessageDetailsEvent {}

class FacultyMessageDetailsInitialEvent extends FacultyMessageDetailsEvent{
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;


  FacultyMessageDetailsInitialEvent({required this.id, required this.title, required this.content, required this.sender, required this.toWhom, required this.fileInfo, required this.timestamp});
}
class FacultyEditSuccessMessageEvent extends FacultyMessageDetailsEvent {
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;
  final String batchId;

  FacultyEditSuccessMessageEvent({required this.id, required this.title, required this.content, required this.sender, required this.toWhom, required this.fileInfo, required this.timestamp, required this.batchId});


}
