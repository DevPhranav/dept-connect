import '../entites/batchSeniorTutorList.dart';

abstract class DropdownDataSource {
  Future<List<FacultySeniorTutorEntity>> fetchDropdownItems();
}
