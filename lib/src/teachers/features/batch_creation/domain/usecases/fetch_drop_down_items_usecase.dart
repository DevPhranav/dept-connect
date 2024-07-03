
import '../entites/batchSeniorTutorList.dart';
import '../repositories/DropDownRepository.dart';

class FetchDropdownItemsUseCase {
  final DropdownRepository repository;

  FetchDropdownItemsUseCase({required this.repository});

  Future<List<String>> call() async {
    final List<FacultySeniorTutorEntity> facultySeniorTutors = await repository.fetchDropdownItems();
    return facultySeniorTutors.map((tutor) => '${tutor.id} ${tutor.name}${tutor.alreadyBatchSeniorTutor ? ' 1' : ''}').toList();
  }
}
