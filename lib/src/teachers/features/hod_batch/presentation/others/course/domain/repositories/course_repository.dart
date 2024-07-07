import '../entities/course_faculty_details.dart';

abstract class CourseRepository {
  Future<List<CourseFacultyDetails>> getCoursesWithFacultyDetails(String batchId,String semester);
}
