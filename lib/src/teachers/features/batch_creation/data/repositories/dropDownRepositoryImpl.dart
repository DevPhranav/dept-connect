
import '../../domain/entites/batchSeniorTutorList.dart';
import '../../domain/repositories/DropDownRepository.dart';
import '../../domain/repositories/drop_down_data_source.dart';

class DropdownRepositoryImpl implements
    DropdownRepository {
  final DropdownDataSource dataSource;

  DropdownRepositoryImpl({required this.dataSource});

  @override
  Future<List<FacultySeniorTutorEntity>> fetchDropdownItems() async {
    try {
      return await dataSource.fetchDropdownItems();
    } catch (e) {
      throw Exception('Error fetching dropdown items: $e');
    }
  }
}
