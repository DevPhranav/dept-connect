import '../entities/faculty.dart';
import '../entities/teacher.dart';
import '../repositories/people_repository.dart';

class GetTeachers {
  final PeopleRepository repository;

  GetTeachers({ required this.repository});

  Future<List<Teacher>> call(String batchId,String section) async {
    return await repository.getTeachers(batchId,section);
  }
}
