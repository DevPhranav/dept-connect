

import '../../domain/entites/course_teacher.dart';
import '../../domain/entites/student.dart';
import '../../domain/entites/tutor.dart';
import '../../domain/repositories/batch_create_datasource.dart';
import '../../domain/repositories/batch_create_repository.dart';

class BatchRepositoryImpl implements BatchRepository {
  final BatchDataSource batchDataSource;

  BatchRepositoryImpl({required this.batchDataSource});

  @override
  Future<void> pushBatchData(Map<String, dynamic> batchData, List<Student> students, List<CourseTeacher> courseTeachers, List<Tutor> tutors) async {
    await batchDataSource.pushBatchData(batchData, students, courseTeachers, tutors);
  }

  @override
  Future<bool> checkBatchYearExists(String batchYear) async {
    return await batchDataSource.checkBatchYearExists(batchYear);
  }
}
