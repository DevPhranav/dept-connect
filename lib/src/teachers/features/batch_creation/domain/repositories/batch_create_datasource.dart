import '../entites/course_teacher.dart';
import '../entites/student.dart';
import '../entites/tutor.dart';

abstract class BatchDataSource {
  Future<void> pushBatchData(Map<String, dynamic> batchData, List<Student> students, List<CourseTeacher> courseTeachers, List<Tutor> tutors);
  Future<bool> checkBatchYearExists(String batchYear);
}
