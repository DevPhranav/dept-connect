import 'dart:io';
import '../../domain/repositories/FirestoreDataSource.dart';
import '../../domain/repositories/MessageRepository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final FirestoreDataSource firestoreDataSource;

  MessageRepositoryImpl(this.firestoreDataSource);



  @override
  Future<void> removeMessage(String id,  List<Map<String, dynamic>> fileInfo,String batchId) {
    return firestoreDataSource.removeMessage(id,fileInfo,batchId);
  }
}