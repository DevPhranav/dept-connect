import 'package:equatable/equatable.dart';
import '../../domain/entities/faculty.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/teacher.dart';
import '../../domain/entities/tutor.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();

  @override
  List<Object> get props => [];
}

class PeopleInitial extends PeopleState {}

class PeopleLoading extends PeopleState {}

class PeopleLoaded extends PeopleState {
  final List<Tutor> tutor;
  final List<Teacher> teacher;
  final List<Student> students;

  PeopleLoaded({required this.tutor, required this.teacher, required this.students});



}

class PeopleError extends PeopleState {
  final String message;

  const PeopleError({required this.message});

  @override
  List<Object> get props => [message];
}

