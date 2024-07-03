import '../../data/models/auth_user_model.dart';

import '../repositories/secure_storage_repository.dart';

class SaveUserDataUseCase {
  final SecureStorageRepository secureStorageRepository;

  SaveUserDataUseCase(this.secureStorageRepository);

  Future<void> execute({
    required AuthUserModel authUser,
  }) async {
    await secureStorageRepository.saveUserData(
      authUser: authUser,
    );
  }
}
