import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/hod_batch/presentation/others/stream/stream_main/domain/repositories/MessageRepository.dart';
import '../entities/facultyAnnouncementMessage.dart';


class FacultyMessageUseCase {
  final MessageRepository messageRepository;

  FacultyMessageUseCase({required this.messageRepository});

  Future<void> removeMessage(String id,List<Map<String,dynamic>> fileInfo,String batchId) async {
    try {
      await messageRepository.removeMessage(id,fileInfo,batchId);
    } catch (error) {
      throw Exception('Failed to remove message: $error');
    }
  }

  Future<List<FacultyAnnouncementMessage>> loadMessages(String facultyId) async {
    try {
      final batchesSnapshot = await FirebaseFirestore.instance
          .collection('departments')
          .doc('CSE')
          .collection('batches')
          .get();

      List<FacultyAnnouncementMessage> allMessages = [];

      for (var batchDoc in batchesSnapshot.docs) {
        final batchData = batchDoc.data();
        final batchId = batchDoc.id;

        // Fetch senior tutor messages
        if (batchData['senior_tutor_id'] == facultyId) {
          final snapshot = await FirebaseFirestore.instance
              .collection('departments')
              .doc('CSE')
              .collection('batches')
              .doc(batchId)
              .collection('batchesMessages')
              .get();

          final seniorTutorMessages = snapshot.docs.map((doc) {
            final data = doc.data();
            final List<dynamic> toWhom = data['toWhom'] ?? [];
            final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
                ? List<Map<String, dynamic>>.from(data['fileInfo'])
                : [];
            final dynamic timestamp = data['timestamp'];
            final dynamic editedTimestamp = data['editedDate'];

            // Only include messages where toWhom contains 'seniorTutor'
            if (toWhom.contains('seniorTutor')) {
              return FacultyAnnouncementMessage(
                id: data['id'] ?? '',
                title: data['title'] ?? '',
                content: data['content'] ?? '',
                sender: data['sender'] ?? '',
                toWhom: toWhom,
                fileInfo: fileInfo,
                timestamp: timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now(),
                editedTimestamp: editedTimestamp != null ? (editedTimestamp as Timestamp).toDate() : DateTime.now(),
              );
            } else {
              return null; // Exclude messages not meant for senior tutors
            }
          }).where((msg) => msg != null).toList(); // Filter out null messages

          allMessages.addAll(seniorTutorMessages.cast<FacultyAnnouncementMessage>()); // Cast to non-nullable type
        }

        // Fetch semester documents
        final semestersSnapshot = await FirebaseFirestore.instance
            .collection('departments')
            .doc('CSE')
            .collection('batches')
            .doc(batchId)
            .collection('semester')
            .get();

        for (var semesterDoc in semestersSnapshot.docs) {
          final semesterData = semesterDoc.data();
          List<FacultyAnnouncementMessage> semesterMessages = [];

          // Check if facultyId is in teachers_sec1 or teachers_sec2
          if (semesterData['teachers_sec1'] != null && (semesterData['teachers_sec1'] as List<dynamic>).contains(facultyId)) {
            // Fetch messages for teachers_sec1
            final snapshot = await FirebaseFirestore.instance
                .collection('departments')
                .doc('CSE')
                .collection('batches')
                .doc(batchId)
                .collection('batchesMessages')
                .where('toWhom', arrayContains: 'tSec1')
                .get();

            semesterMessages = snapshot.docs.map((doc) {
              final data = doc.data();
              final List<dynamic> toWhom = data['toWhom'] ?? [];
              final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
                  ? List<Map<String, dynamic>>.from(data['fileInfo'])
                  : [];
              final dynamic timestamp = data['timestamp'];
              final dynamic editedTimestamp = data['editedDate'];

              return FacultyAnnouncementMessage(
                id: data['id'] ?? '',
                title: data['title'] ?? '',
                content: data['content'] ?? '',
                sender: data['sender'] ?? '',
                toWhom: toWhom,
                fileInfo: fileInfo,
                timestamp: timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now(),
                editedTimestamp: editedTimestamp != null ? (editedTimestamp as Timestamp).toDate() : DateTime.now(),
              );
            }).toList();
          } else if (semesterData['teachers_sec2'] != null && (semesterData['teachers_sec2'] as List<dynamic>).contains(facultyId)) {
            // Fetch messages for teachers_sec2
            final snapshot = await FirebaseFirestore.instance
                .collection('departments')
                .doc('CSE')
                .collection('batches')
                .doc(batchId)
                .collection('batchesMessages')
                .where('toWhom', arrayContains: 'tSec2')
                .get();

            semesterMessages = snapshot.docs.map((doc) {
              final data = doc.data();
              final List<dynamic> toWhom = data['toWhom'] ?? [];
              final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
                  ? List<Map<String, dynamic>>.from(data['fileInfo'])
                  : [];
              final dynamic timestamp = data['timestamp'];
              final dynamic editedTimestamp = data['editedDate'];

              return FacultyAnnouncementMessage(
                id: data['id'] ?? '',
                title: data['title'] ?? '',
                content: data['content'] ?? '',
                sender: data['sender'] ?? '',
                toWhom: toWhom,
                fileInfo: fileInfo,
                timestamp: timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now(),
                editedTimestamp: editedTimestamp != null ? (editedTimestamp as Timestamp).toDate() : DateTime.now(),
              );
            }).toList();
          }

          allMessages.addAll(semesterMessages);
        }
      }

      // Sort all messages by timestamp
      allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return allMessages;
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }
  Stream<List<FacultyAnnouncementMessage>> getMessageStream(String facultyId) {
    return FirebaseFirestore.instance
        .collection('departments')
        .doc('CSE')
        .collection('batches')
        .snapshots()
        .asyncMap((batchesSnapshot) async {
      List<FacultyAnnouncementMessage> allMessages = [];

      for (var batchDoc in batchesSnapshot.docs) {
        final batchData = batchDoc.data();
        final batchId = batchDoc.id;

        // Fetch senior tutor messages
        if (batchData['senior_tutor_id'] == facultyId) {
          final snapshot = await FirebaseFirestore.instance
              .collection('departments')
              .doc('CSE')
              .collection('batches')
              .doc(batchId)
              .collection('batchesMessages')
              .where('toWhom', arrayContains: 'seniorTutor')
              .get();

          final seniorTutorMessages = snapshot.docs.map((doc) {
            final data = doc.data();
            final List<dynamic> toWhom = data['toWhom'] ?? [];
            final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
                ? List<Map<String, dynamic>>.from(data['fileInfo'])
                : [];
            final dynamic timestamp = data['timestamp'];
            final dynamic editedTimestamp = data['editedDate'];

            return FacultyAnnouncementMessage(
              id: data['id'] ?? '',
              title: data['title'] ?? '',
              content: data['content'] ?? '',
              sender: data['sender'] ?? '',
              toWhom: toWhom,
              fileInfo: fileInfo,
              timestamp: timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now(),
              editedTimestamp: editedTimestamp != null ? (editedTimestamp as Timestamp).toDate() : DateTime.now(),
            );
          }).toList();

          allMessages.addAll(seniorTutorMessages);
        }

        // Fetch semester documents
        final semestersSnapshot = await FirebaseFirestore.instance
            .collection('departments')
            .doc('CSE')
            .collection('batches')
            .doc(batchId)
            .collection('semester')
            .get();

        for (var semesterDoc in semestersSnapshot.docs) {
          final semesterData = semesterDoc.data();
          List<FacultyAnnouncementMessage> semesterMessages = [];

          // Check if facultyId is in teachers_sec1
          if (semesterData['teachers_sec1'] != null && (semesterData['teachers_sec1'] as List<dynamic>).contains(facultyId)) {
            final snapshot = await FirebaseFirestore.instance
                .collection('departments')
                .doc('CSE')
                .collection('batches')
                .doc(batchId)
                .collection('batchesMessages')
                .where('toWhom', arrayContains: 'tSec1')
                .get();

            semesterMessages = snapshot.docs.map((doc) {
              final data = doc.data();
              final List<dynamic> toWhom = data['toWhom'] ?? [];
              final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
                  ? List<Map<String, dynamic>>.from(data['fileInfo'])
                  : [];
              final dynamic timestamp = data['timestamp'];
              final dynamic editedTimestamp = data['editedDate'];

              return FacultyAnnouncementMessage(
                id: data['id'] ?? '',
                title: data['title'] ?? '',
                content: data['content'] ?? '',
                sender: data['sender'] ?? '',
                toWhom: toWhom,
                fileInfo: fileInfo,
                timestamp: timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now(),
                editedTimestamp: editedTimestamp != null ? (editedTimestamp as Timestamp).toDate() : DateTime.now(),
              );
            }).toList();
          }

          // Check if facultyId is in teachers_sec2
          if (semesterData['teachers_sec2'] != null && (semesterData['teachers_sec2'] as List<dynamic>).contains(facultyId)) {
            final snapshot = await FirebaseFirestore.instance
                .collection('departments')
                .doc('CSE')
                .collection('batches')
                .doc(batchId)
                .collection('batchesMessages')
                .where('toWhom', arrayContains: 'tSec2')
                .get();

            final messages = snapshot.docs.map((doc) {
              final data = doc.data();
              final List<dynamic> toWhom = data['toWhom'] ?? [];
              final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
                  ? List<Map<String, dynamic>>.from(data['fileInfo'])
                  : [];
              final dynamic timestamp = data['timestamp'];
              final dynamic editedTimestamp = data['editedDate'];

              return FacultyAnnouncementMessage(
                id: data['id'] ?? '',
                title: data['title'] ?? '',
                content: data['content'] ?? '',
                sender: data['sender'] ?? '',
                toWhom: toWhom,
                fileInfo: fileInfo,
                timestamp: timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now(),
                editedTimestamp: editedTimestamp != null ? (editedTimestamp as Timestamp).toDate() : DateTime.now(),
              );
            }).toList();

            semesterMessages.addAll(messages);
          }

          allMessages.addAll(semesterMessages);
        }
      }

      // Sort all messages by timestamp
      allMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return allMessages;
    });
  }

}
