import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
  });


  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
    required String userType,
  }) async {
    final authModel = await remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
      userType: userType,
    );
    return authModel.toEntity();
  }
  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();

  }
}
