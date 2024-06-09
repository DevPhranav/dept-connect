import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miniproject_authentication/src/features/auth/data/models/auth_user_model.dart';
import 'package:miniproject_authentication/src/features/auth/data/repositories/secure_storage_repository_impl.dart';
import 'package:miniproject_authentication/src/features/auth/domain/use_cases/delete_user_data_usecase.dart';
import 'package:miniproject_authentication/src/features/auth/domain/use_cases/save_user_data_usecase.dart';
import 'package:miniproject_authentication/src/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:miniproject_authentication/src/features/auth/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:miniproject_authentication/src/features/auth/presentation/blocs/sign_out/sign_out_bloc.dart';
import 'package:miniproject_authentication/src/features/auth/presentation/screens/home_screen.dart';
import 'package:miniproject_authentication/src/features/auth/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/features/auth/domain/repositories/secure_storage_repository.dart';
import 'src/features/auth/presentation/screens/sign_in_screen.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations to portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const SplashScreen());
  await Future.delayed(const Duration(seconds: 5));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(await builder());
}

void main() {
  bootstrap(
        () async {
      AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceFirebase();

      AuthRepository authRepository = AuthRepositoryImpl(
        remoteDataSource: authRemoteDataSource,
      );

      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      SecureStorageRepository secureStorageRepository = SecureStorageRepositoryImpl(secureStorage);

      // Check if user data exists in SecureStorage
      final userData = await secureStorageRepository.getUserData();
      final userExists = userData != null;

      // Navigate based on user existence
      return App(
        authRepository: authRepository,
        secureStorageRepository: secureStorageRepository,
        initialRoute: userExists ? '/home' : '/login',
        user: userData,
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authRepository,
    required this.secureStorageRepository,
    required this.initialRoute,
    required this.user,
  }) : super(key: key);

  final AuthRepository authRepository;
  final SecureStorageRepository secureStorageRepository;
  final String initialRoute;
  final AuthUserModel? user;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: secureStorageRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              signInUseCase: SignInUseCase(authRepository: authRepository),
              saveUserDataUseCase: SaveUserDataUseCase(secureStorageRepository),
            ),
          ),
          BlocProvider<SignOutBloc>(
            create: (context) => SignOutBloc(
              authRepository: authRepository,
              deleteUserDataUseCase: DeleteUserDataUseCase(secureStorageRepository),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Clean Architecture',
          theme: ThemeData.light(useMaterial3: true),
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const SignInView(),
            '/home': (context) => HomeScreen(user: user), // Assuming you have a HomeScreen widget
          },
        ),
      ),
    );
  }
}
