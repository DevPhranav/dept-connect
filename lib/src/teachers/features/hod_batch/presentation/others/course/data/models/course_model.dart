import '../../domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.courseId,
    required super.facultyId,
    required super.section,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseId: map['courseId'],
      facultyId: map['id'],
      section: map['section'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'facultyId': facultyId,
      'section': section,
    };
  }
}
