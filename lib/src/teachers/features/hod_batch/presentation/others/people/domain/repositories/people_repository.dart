
import '../entities/student.dart';
import '../entities/teacher.dart';
import '../entities/tutor.dart';

abstract class PeopleRepository {
  Future<List<Tutor>> getTutors(String batchId, String section);

  Future<List<Teacher>> getTeachers(String batchId, String section);

  Future<List<Student>> getStudents(String batchId, String section);
}
