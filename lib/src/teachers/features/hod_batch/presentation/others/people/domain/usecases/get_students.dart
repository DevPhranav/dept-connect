import '../entities/student.dart';
import '../repositories/people_repository.dart';

class GetStudents {
  final PeopleRepository repository;

  GetStudents({required this.repository});

  Future<List<Student>> call(String batchId, String section) async {
    return await repository.getStudents(batchId, section);
  }
}
