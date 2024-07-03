
import '../repositories/batch_create_repository.dart';

class BatchYearCheckUseCase {
  final BatchRepository batchRepository;

  BatchYearCheckUseCase({required this.batchRepository});

  Future<String> execute(String batchYear) async {
    try {
      bool exists = await batchRepository.checkBatchYearExists(batchYear);
      if (exists) {
        return ('Batch year already exists');
      } else {
        return "batch year is not exists";
      }
    } catch (e) {
      return ('Error checking batch year: $e');
    }
  }
}
