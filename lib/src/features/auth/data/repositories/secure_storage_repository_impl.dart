import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/secure_storage_repository.dart';
import '../models/auth_user_model.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final FlutterSecureStorage _secureStorage;

  SecureStorageRepositoryImpl(this._secureStorage);

  @override
  Future<void> saveUserData({
    required String email,
    required String id,
    required String department,
  }) async {
    AuthUserModel user =
        AuthUserModel(id: id, email: email, department: department);
    String userDataJson =
        jsonEncode(user.toJson()); // Convert AuthUserModel to JSON string
    await _secureStorage.write(key: 'userData', value: userDataJson);
  }

  @override
  Future<AuthUserModel?> getUserData() async {
    String? userDataJson = await _secureStorage.read(key: 'userData');
    if (userDataJson != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return AuthUserModel.fromJson(userDataMap);
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteUserData() async {
    await _secureStorage.delete(key: 'userData');
  }
}
