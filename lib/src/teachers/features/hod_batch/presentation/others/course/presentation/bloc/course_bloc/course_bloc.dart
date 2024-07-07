import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/domain/usecases/get_courses_usecase.dart';

import '../../../domain/entities/course.dart';
import '../../../domain/entities/course_faculty_details.dart';


part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCoursesWithFacultyDetailsUseCase getCoursesWithFacultyDetailsUseCase;

  CourseBloc({required this.getCoursesWithFacultyDetailsUseCase}) : super(CourseInitial()) {
    on<LoadCourses>(_onLoadCourses);
  }

  void _onLoadCourses(LoadCourses event, Emitter<CourseState> emit) async {
    emit(CourseLoading());
    try {
      final courses = await getCoursesWithFacultyDetailsUseCase(event.batchId,event.semesterNo);
      emit(CourseLoaded(courses: courses));
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }
}
