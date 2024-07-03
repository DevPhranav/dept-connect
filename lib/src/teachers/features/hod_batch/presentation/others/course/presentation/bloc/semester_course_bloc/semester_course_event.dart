// Events
abstract class SemesterEvent {}

class LoadSemesters extends SemesterEvent {
  final String batchId;

  LoadSemesters(this.batchId);
}