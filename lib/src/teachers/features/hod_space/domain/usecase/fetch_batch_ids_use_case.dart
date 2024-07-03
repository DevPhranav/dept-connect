
import '../repositories/hod_batch_repository.dart';

class FetchBatchIdsUseCase {
  final HodBatchRepository repository;

  FetchBatchIdsUseCase({required this.repository});

  Future<List<String>> call(String dept) async {
    try {
      return await repository.fetchBatchIds(dept);
    } catch (error) {
      throw error;
    }
  }
}
