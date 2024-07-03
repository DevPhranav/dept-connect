import '../../domain/entities/semester.dart';
import '../../domain/repositories/semester_repository.dart';
import '../data_sources/semester_datasource.dart';


class SemesterRepositoryImpl implements SemesterRepository {
  final SemesterDataSource dataSource;

  SemesterRepositoryImpl({required this.dataSource});

  @override
  Future<List<Semester>> getSemesters(String batchId) async {
    final semesters = await dataSource.fetchSemesters(batchId);
    return semesters.map((model) => model.toEntity()).toList();
  }
}
