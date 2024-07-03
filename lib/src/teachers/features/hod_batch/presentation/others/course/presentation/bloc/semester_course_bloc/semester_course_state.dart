
import '../../../domain/entities/semester.dart';

abstract class SemesterState {}

class SemesterInitial extends SemesterState {}

class SemesterLoading extends SemesterState {}

class SemesterLoaded extends SemesterState {
  final List<Semester> semesters;

  SemesterLoaded(this.semesters);
}

class SemesterError extends SemesterState {
  final String message;

  SemesterError(this.message);
}
