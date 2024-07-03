class AnnouncementMessage {
  final String id;
  final String title;
  final String content;
  final String sender;
  final List<dynamic> toWhom;
  final List<Map<String, dynamic>> fileInfo;
  final DateTime timestamp;
  final DateTime editedTimestamp;


  AnnouncementMessage({
    required this.title,
    required this.content,
    required this.sender,
    required this.toWhom,
    required this.fileInfo,
    required this.timestamp,
    required this.id,
    required this.editedTimestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'Sender': sender,
      'timestamp': timestamp,
      'toWhom': toWhom,
      'fileInfo': fileInfo,
      'id':id,
      'editedTimestamp':editedTimestamp,
    };
  }

  factory AnnouncementMessage.fromMap(Map<String, dynamic> map) {
    return AnnouncementMessage(
      id:map['id'],
      title: map['title'],
      content: map['content'],
      sender: map['Sender'],
      toWhom: List<dynamic>.from(map['toWhom']),
      fileInfo: List<Map<String, String>>.from(map['fileInfo']),
      timestamp: map['timestamp'],
      editedTimestamp: map['editedTimestamp'],
    );
  }
}
