
import '../entites/course_teacher.dart';
import '../entites/student.dart';
import '../entites/tutor.dart';
import '../repositories/batch_create_repository.dart';

class PushBatchDataUseCase {
  final BatchRepository batchRepository;

  PushBatchDataUseCase({required this.batchRepository});

  Future<void> execute(Map<String, dynamic> batchData, List<Student> students, List<CourseTeacher> courseTeachers, List<Tutor> tutors) async {
    await batchRepository.pushBatchData(batchData, students, courseTeachers, tutors);
  }
}
