import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String courseId;
  final String facultyId;
  final String section;

  const Course({
    required this.courseId,
    required this.facultyId,
    required this.section,
  });

  @override
  List<Object> get props => [courseId, facultyId, section];
}
