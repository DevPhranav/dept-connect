
import '../entities/teacher.dart';
import '../entities/tutor.dart';
import '../repositories/people_repository.dart';

class GetTutors {
  final PeopleRepository repository;

  GetTutors({ required this.repository});

  Future<List<Tutor>> call(String batchId,String section) async {
    return await repository.getTutors(batchId,section);
  }
}
