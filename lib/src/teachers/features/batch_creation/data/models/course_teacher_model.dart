import '../../domain/entites/course_teacher.dart';

class CourseTeacherModel {
  final String id;
  final String courseId;
  final String section;

  CourseTeacherModel({
    required this.id,
    required this.courseId,
    required this.section,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'section': section,
    };
  }

  CourseTeacher toEntity() {
    return CourseTeacher(
      id: id,
      course_id: courseId,
      section: section,
    );
  }
}
