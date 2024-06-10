
import '../../data/models/auth_user_model.dart';

abstract class SecureStorageRepository {
  Future<void> saveUserData({
    required String email,
    required String id,
    required String? department,
    required String? userType,
  });

  Future<AuthUserModel?> getUserData();

  Future<void> deleteUserData();
}
