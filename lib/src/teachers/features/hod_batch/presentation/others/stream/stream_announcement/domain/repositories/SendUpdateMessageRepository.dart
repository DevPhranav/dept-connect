import 'dart:io';

abstract class SendMessageRepository{
  Future<String> sendMessageToFirebase(String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, List<File> pickedFiles, DateTime editedDate,String docId,String batchId);
  Future<Map<String, dynamic>> updateMessageToFirebase(String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, List<File> pickedFiles, DateTime editedDate,String docId,String batchId);

}