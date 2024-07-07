part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class LoadCourses extends CourseEvent {
  final String batchId;
  final String semesterNo;

  LoadCourses(this.batchId, this.semesterNo);



  @override
  List<Object> get props => [batchId];
}
