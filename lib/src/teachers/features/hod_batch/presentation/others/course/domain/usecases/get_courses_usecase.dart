import '../entities/course_faculty_details.dart';
import '../repositories/course_repository.dart';

class GetCoursesWithFacultyDetailsUseCase {
  final CourseRepository repository;

  GetCoursesWithFacultyDetailsUseCase({required this.repository});

  Future<List<CourseFacultyDetails>> call(String batchId,String semester) {
    return repository.getCoursesWithFacultyDetails(batchId, semester);
  }
}
