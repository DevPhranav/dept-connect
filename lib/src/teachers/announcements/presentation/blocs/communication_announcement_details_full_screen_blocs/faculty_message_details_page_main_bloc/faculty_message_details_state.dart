// States
abstract class FacultyMessageDetailsState {}

class FacultyMessageDetailsInitial extends FacultyMessageDetailsState {
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final String timestamp;


  FacultyMessageDetailsInitial(
      {required this.id,
        required this.title,
        required this.content,
        required this.sender,
        required this.toWhom,
        required this.fileInfo,
        required this.timestamp,});
}

class FacultyMessageEditingState extends FacultyMessageDetailsState {}
