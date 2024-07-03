import 'dart:io';

abstract class FirestoreDataSource {
  Future<Map<String, dynamic>>  updateMessageToFirebase(String messageId, String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, DateTime editedDate, List<File> newFiles,String batchId,);

  Future<void> removeMessage(String id,List<Map<String, dynamic>> fileInfo,String batchId);
}