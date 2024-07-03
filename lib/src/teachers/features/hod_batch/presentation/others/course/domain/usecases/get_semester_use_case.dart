import '../entities/semester.dart';
import '../repositories/semester_repository.dart';

class GetSemestersUseCase {
  final SemesterRepository repository;

  GetSemestersUseCase(this.repository);

  Future<List<Semester>> call(String batchId) async {
    return await repository.getSemesters(batchId);
  }
}
