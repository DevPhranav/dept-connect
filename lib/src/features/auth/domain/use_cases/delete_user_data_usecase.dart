
import '../repositories/secure_storage_repository.dart';

class DeleteUserDataUseCase {
  final SecureStorageRepository secureStorageRepository;

  DeleteUserDataUseCase(this.secureStorageRepository);

  Future<void> execute() async {
    await secureStorageRepository.deleteUserData();
  }
}
