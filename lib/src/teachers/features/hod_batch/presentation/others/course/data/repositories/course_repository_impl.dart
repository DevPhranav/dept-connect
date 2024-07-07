import '../../domain/entities/course_faculty_details.dart';
import '../../domain/repositories/course_repository.dart';
import '../data_sources/course_firebase_datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseFirebaseDataSource dataSource;

  CourseRepositoryImpl(this.dataSource);

  @override
  Future<List<CourseFacultyDetails>> getCoursesWithFacultyDetails(String batchId, String semester) async {
    try {
      final courses = await dataSource.getCourses(batchId);
      final List<CourseFacultyDetails> coursesWithDetails = [];

      for (var course in courses) {
        final faculty = await dataSource.getFacultyDetails(course.facultyId);
        final courseDetailsList = await dataSource.getCourseDetails(course.courseId, semester);
        print(courseDetailsList);

        for (var courseDetails in courseDetailsList) {
          coursesWithDetails.add(CourseFacultyDetails(
            courseId: course.courseId,
            section: course.section,
            facultyName: faculty.name,
            facultyEmail: faculty.email,
            courseName: courseDetails.name,
            courseCredit: courseDetails.credit,
          ));
        }
      }

      return coursesWithDetails;
    } catch (e) {
      throw Exception('Failed to get courses with faculty details: $e');
    }
  }
}
