import '../models/semester_model.dart';

abstract class SemesterDataSource {
  Future<List<SemesterModel>> fetchSemesters(String batchId);
}


