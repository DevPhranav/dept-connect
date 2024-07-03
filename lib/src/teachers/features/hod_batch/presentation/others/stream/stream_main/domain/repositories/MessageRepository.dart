import 'dart:io';
import '../../data/data_source/firestore_data_source_impl.dart';

abstract class MessageRepository {
  Future<void> removeMessage(String id, List<Map<String, dynamic>> fileInfo,String batchId);
}


