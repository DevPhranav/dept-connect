import 'dart:io';

abstract class FirestoreSendDataSource {
  Future<String> sendMessageToFirebase(String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, List<File> pickedFiles, DateTime editedDate, String batchId);
  Future<String> updateMessageToFirebase(String messageId, String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, DateTime editedDate, List<File> newFiles,String batchId,);
}