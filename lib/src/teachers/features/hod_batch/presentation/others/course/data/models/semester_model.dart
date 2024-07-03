
import '../../domain/entities/semester.dart';

class SemesterModel {
  final String id;
  final String title;

  SemesterModel({required this.id, required this.title});

  // Convert model to entity
  Semester toEntity() => Semester(id: id, title: title);
}
