import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/people/domain/entities/teacher.dart';

import '../../domain/entities/student.dart';
import '../../domain/usecases/get_teachers.dart';
import 'people_event.dart';
import 'people_state.dart';
import '../../domain/usecases/get_tutors.dart';
import '../../domain/usecases/get_students.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final GetTeachers getTeachers;
  final GetTutors getTutors;
  final GetStudents getStudents;

  PeopleBloc({required this.getTeachers,required this.getTutors, required this.getStudents}) : super(PeopleInitial()) {
    on<LoadPeople>(_onLoadPeople);
  }

  void _onLoadPeople(LoadPeople event, Emitter<PeopleState> emit) async {
    emit(PeopleLoading());
    try {
      final List<Teacher> teachers= await getTeachers(event.batchId,event.section);
      final tutors = await getTutors(event.batchId,event.section);
      final List<Student> students = await getStudents(event.batchId, event.section);
      emit(PeopleLoaded(tutor: tutors, teacher: teachers, students: students));
    } catch (e) {
      emit(PeopleError(message: e.toString()));
    }
  }
}
