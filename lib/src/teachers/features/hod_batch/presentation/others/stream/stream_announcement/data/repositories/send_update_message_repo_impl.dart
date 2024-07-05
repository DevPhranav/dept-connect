import 'dart:io';


import '../../../stream_main/domain/repositories/FirestoreDataSource.dart';
import '../../domain/repositories/FirestoreDataSource.dart';
import '../../domain/repositories/SendUpdateMessageRepository.dart';

class SendMessageRepositoryImpl extends SendMessageRepository {
  final FirestoreSendDataSource firestoreSendDataSource;
  final FirestoreDataSource firestoreDataSource;

  SendMessageRepositoryImpl({required this.firestoreSendDataSource, required this.firestoreDataSource});


  @override
  Future<String> sendMessageToFirebase(String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, List<File> pickedFiles, DateTime editedDate, String docId, String batchId,String? sender) {
    return firestoreSendDataSource.sendMessageToFirebase(announcementMessage,
        titleMessage, checkboxes, pickedFiles, editedDate, batchId,sender);
  }

  @override
  Future<Map<String, dynamic>> updateMessageToFirebase(String announcementMessage, String titleMessage, List<Map<String, dynamic>> checkboxes, List<File> pickedFiles, DateTime editedDate, String docId, String batchId) {
    return firestoreDataSource.updateMessageToFirebase(docId,announcementMessage,titleMessage,checkboxes,editedDate,pickedFiles,batchId);
  }



}
