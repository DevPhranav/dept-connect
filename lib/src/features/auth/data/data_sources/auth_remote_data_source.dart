import '../models/auth_user_model.dart';

abstract class AuthRemoteDataSource {

  Future<AuthUserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String userType,
  });

   Future<void> signOut();
}
