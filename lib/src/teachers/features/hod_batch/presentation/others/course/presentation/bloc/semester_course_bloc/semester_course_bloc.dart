
// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/presentation/bloc/semester_course_bloc/semester_course_event.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/presentation/bloc/semester_course_bloc/semester_course_state.dart';

import '../../../domain/usecases/get_semester_use_case.dart';
class SemesterBloc extends Bloc<SemesterEvent, SemesterState> {
  final GetSemestersUseCase getSemestersUseCase;

  SemesterBloc({required this.getSemestersUseCase}) : super(SemesterInitial()) {
    on<LoadSemesters>((event, emit) async {
      emit(SemesterLoading());
      try {
        final semesters = await getSemestersUseCase(event.batchId);
        emit(SemesterLoaded(semesters));
      } catch (e) {
        emit(SemesterError(e.toString()));
      }
    });
  }
}
