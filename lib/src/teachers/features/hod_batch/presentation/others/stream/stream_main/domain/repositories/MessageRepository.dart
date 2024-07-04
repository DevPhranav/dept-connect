
abstract class MessageRepository {
  Future<void> removeMessage(String id, List<Map<String, dynamic>> fileInfo,String batchId);
}


