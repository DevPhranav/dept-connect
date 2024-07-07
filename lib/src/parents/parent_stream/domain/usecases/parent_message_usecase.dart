import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../entites/parentAnnouncementMessage.dart';

class ParentMessageUseCase {
  Future<List<ParentAnnouncementMessage>> loadMessages(String? batchId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('departments')
          .doc('CSE')
          .collection('batches')
          .doc(batchId)
          .collection('batchesMessages')
          .get();

      final messages = snapshot.docs.map((doc) {
        final data = doc.data();
        final List<dynamic> toWhom = data['toWhom'] ?? [];
        final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
            ? List<Map<String, dynamic>>.from(data['fileInfo'])
            : [];
        final dynamic timestamp = data['timestamp'];
        final dynamic editedTimestamp = data['editedDate'];

        return ParentAnnouncementMessage(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          content: data['content'] ?? '',
          sender: data['sender'] ?? '',
          toWhom: toWhom,
          fileInfo: fileInfo,
          timestamp: timestamp != null
              ? (timestamp as Timestamp).toDate()
              : DateTime.now(),
          editedTimestamp: editedTimestamp != null
              ? (editedTimestamp as Timestamp).toDate()
              : DateTime.now(),
        );
      }).where((message) {
        return message.toWhom.contains('pSec1') || message.toWhom.contains('pSec2');
      }).toList();

      // Sort messages by timestamp
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return messages;
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  Stream<List<ParentAnnouncementMessage>> getMessageStream(String batchId) {
    return FirebaseFirestore.instance
        .collection('departments')
        .doc('CSE')
        .collection('batches')
        .doc(batchId)
        .collection('batchesMessages')
        .snapshots()
        .map((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data();
        final List<dynamic> toWhom = data['toWhom'] ?? [];
        final List<Map<String, dynamic>> fileInfo = data['fileInfo'] != null
            ? List<Map<String, dynamic>>.from(data['fileInfo'])
            : [];
        final dynamic timestamp = data['timestamp'];
        final dynamic editedTimestamp = data['editedDate'];

        return ParentAnnouncementMessage(
          id: data['id'] ?? '',
          title: data['title'] ?? '',
          content: data['content'] ?? '',
          sender: data['sender'] ?? '',
          toWhom: toWhom,
          fileInfo: fileInfo,
          timestamp: timestamp != null
              ? (timestamp as Timestamp).toDate()
              : DateTime.now(),
          editedTimestamp: editedTimestamp != null
              ? (editedTimestamp as Timestamp).toDate()
              : DateTime.now(),
        );
      }).where((message) {
        return message.toWhom.contains('sSec1') || message.toWhom.contains('sSec2');
      }).toList();

      // Sort messages by timestamp
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return messages;
    });
  }
}
