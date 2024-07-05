import 'dart:io';
import '../repositories/SendUpdateMessageRepository.dart';

class SendUpdateMessageUseCase {
  SendMessageRepository sendUpdateMessageRepository;

  SendUpdateMessageUseCase({required this.sendUpdateMessageRepository});

  Future<String> sendMessage(
      String announcementMessage,
      String titleMessage,
      List<Map<String, dynamic>> checkboxes,
      List<File> pickedFiles,
      DateTime editedDate,
      String docId,
      String batchId,String? sender) async {
    try {
      return await sendUpdateMessageRepository.sendMessageToFirebase(
          announcementMessage,
          titleMessage,
          checkboxes,
          pickedFiles,
          editedDate,
          docId,
          batchId,sender);
    } catch (error) {
      throw Exception('Failed to send message: $error');
    }
  }

  Future<Map<String, dynamic>> updateMessage(
      String announcementMessage,
      String titleMessage,
      List<Map<String, dynamic>> checkboxes,
      List<File> pickedFiles,
      DateTime editedDate,
      String docId,
      String batchId) async {
    try {
      return await sendUpdateMessageRepository.updateMessageToFirebase(
          announcementMessage,
          titleMessage,
          checkboxes,
          pickedFiles,
          editedDate,
          docId,
          batchId);
    } catch (error) {
      throw Exception('Failed to send message: $error');
    }
  }
}
