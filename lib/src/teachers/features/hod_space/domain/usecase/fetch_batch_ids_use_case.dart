
import '../repositories/hod_batch_repository.dart';

class FetchBatchIdsUseCase {
  final HodBatchRepository repository;

  FetchBatchIdsUseCase({required this.repository});

  Future<List<String>> call(String dept,String facultyId,String role ) async {
    try {
      return await repository.fetchBatchIds(dept,facultyId,role);
    } catch (error) {
      throw error;
    }
  }
}
