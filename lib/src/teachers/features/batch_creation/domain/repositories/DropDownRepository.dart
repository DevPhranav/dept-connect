import '../entites/batchSeniorTutorList.dart';

abstract class DropdownRepository {
  Future<List<FacultySeniorTutorEntity>> fetchDropdownItems();
}
