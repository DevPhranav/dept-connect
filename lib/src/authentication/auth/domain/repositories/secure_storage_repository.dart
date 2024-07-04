
import '../../data/models/auth_user_model.dart';


abstract class SecureStorageRepository {
  Future<void> saveUserData({
    required AuthUserModel authUser,
  });

  Future<AuthUserModel?> getUserData();

  Future<void> deleteUserData();
}
