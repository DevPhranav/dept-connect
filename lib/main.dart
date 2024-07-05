import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/models/auth_user_model.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/repositories/auth_repository_impl.dart';
import 'package:miniproject_authentication/src/authentication/auth/data/repositories/secure_storage_repository_impl.dart';
import 'package:miniproject_authentication/src/authentication/auth/domain/repositories/auth_repository.dart';
import 'package:miniproject_authentication/src/authentication/auth/domain/repositories/secure_storage_repository.dart';
import 'package:miniproject_authentication/src/authentication/auth/domain/use_cases/delete_user_data_usecase.dart';
import 'package:miniproject_authentication/src/authentication/auth/domain/use_cases/save_user_data_usecase.dart';
import 'package:miniproject_authentication/src/authentication/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:miniproject_authentication/src/authentication/auth/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/presentation/blocs/sign_out/sign_out_bloc.dart';
import 'package:miniproject_authentication/src/authentication/auth/presentation/screens/sign_in_screen.dart';
import 'package:miniproject_authentication/src/authentication/auth/presentation/screens/splash_screen.dart';
import 'package:miniproject_authentication/src/students/home_page/presentation/screens/student_space_page.dart';
import 'package:miniproject_authentication/src/students/student_stream/domain/usecases/student_message_usecase.dart';
import 'package:miniproject_authentication/src/students/student_stream/presentation/bloc/student_announcement_details_full_screen_blocs/student_file_download_bloc/file_download_bloc.dart';
import 'package:miniproject_authentication/src/students/student_stream/presentation/bloc/student_announcement_details_full_screen_blocs/student_message_details_page_main_bloc/message_details_page_bloc.dart';
import 'package:miniproject_authentication/src/students/student_stream/presentation/bloc/student_message_show_bloc/message_show_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/data/data_source/batch_creation_data_source_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/data/data_source/drop_down_data_source_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/data/repositories/batch_repository_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/data/repositories/dropDownRepositoryImpl.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/externals/validator/excel_validator.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/repositories/DropDownRepository.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/repositories/batch_create_datasource.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/repositories/batch_create_repository.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/repositories/drop_down_data_source.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/usecases/batch_year_check_use_case.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/usecases/excel_error_check_usecase.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/usecases/fetch_drop_down_items_usecase.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/usecases/pre_process_excel_use_case.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/domain/usecases/push_batch_data_usecase.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/presentation/bloc/batch_creation_bloc/batch_creation_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/presentation/bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/presentation/bloc/batch_year_bloc/batch_year_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/presentation/bloc/file_pick_bloc/file_pick_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/batch_creation/presentation/screens/batch_creation_page.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/bloc/navigation/hod_navigation_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/data/data_sources/semester_datasource.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/data/data_sources/semester_datasource_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/data/repositories/semester_repository_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/domain/repositories/semester_repository.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/domain/usecases/get_semester_use_case.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/presentation/bloc/semester_course_bloc/semester_course_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/course/presentation/pages/hod_batch_course_per_details_page.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/data/datasource/firestore_data_source_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/data/repositories/send_update_message_repo_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/domain/repositories/FirestoreDataSource.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/domain/repositories/SendUpdateMessageRepository.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/domain/use_cases/send_update_message_use_case.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_announcement/presentation/screens/hod_batch_announcement_page.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/data/data_source/firestore_data_source_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/data/repositories/MessageRepositoryImpl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/domain/repositories/FirestoreDataSource.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/domain/repositories/MessageRepository.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/domain/usecases/message_usecase.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/announcement_details_full_screen_blocs/ToWhomCubit/to_whom_cubit.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/announcement_details_full_screen_blocs/message_details_page_main_bloc/message_details_page_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/stream_page_blocs/message_remove_bloc/message_remove_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_batch/presentation/screens/hod_batch_page.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/data/datasource/hod_remote_data_source_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/data/repositories/hod_batch_repository_impl.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/domain/repositories/batch_remote_datasource.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/domain/repositories/hod_batch_repository.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/domain/usecase/fetch_batch_ids_use_case.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/presentation/blocs/hod_space/hod_batch_bloc.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/presentation/screens/hod_space_page.dart';
import 'package:miniproject_authentication/src/teachers/features/hod_space/presentation/screens/navigation_page.dart';
import 'firebase_options.dart';


typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

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
      AuthRemoteDataSource authRemoteDataSource =
          AuthRemoteDataSourceFirebase();
      FirestoreDataSource firestoreDataSource = FirestoreDataSourceImpl();

      AuthRepository authRepository = AuthRepositoryImpl(
        remoteDataSource: authRemoteDataSource,
      );

      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      SecureStorageRepository secureStorageRepository =
          SecureStorageRepositoryImpl(secureStorage);
      MessageRepository messageRepository =
          MessageRepositoryImpl(firestoreDataSource);

      HodBatchRemoteDataSource remoteDataSource =
          HodBatchRemoteDataSourceImpl();
      HodBatchRepository hodBatchRepository =
          HodBatchRepositoryImpl(remoteDataSource: remoteDataSource);

      FirestoreSendDataSource firestoreSendAndUpdateDataSource =
          FirestoreSendDataSourceImpl();

      FirestoreDataSource firestoreUpdateDataSource = FirestoreDataSourceImpl();
      SendMessageRepository sendUpdateMessageRepository =
          SendMessageRepositoryImpl(
              firestoreDataSource: firestoreUpdateDataSource,
              firestoreSendDataSource: firestoreSendAndUpdateDataSource);

      DropdownDataSource dropdownDataSource = FirebaseDropdownDataSource();
      DropdownRepository dropdownRepository =
          DropdownRepositoryImpl(dataSource: dropdownDataSource);
      BatchDataSource dataSource = BatchDataSourceImpl();
      BatchRepository batchRepository =
          BatchRepositoryImpl(batchDataSource: dataSource);
      SemesterDataSource semesterDataSource = SemesterDataSourceImpl();
      SemesterRepository semesterRepository =
          SemesterRepositoryImpl(dataSource: semesterDataSource);

      // Check if user data exists in SecureStorage
      final userData = await secureStorageRepository.getUserData();
      print(userData);
      final userExists = userData != null;
      print(userExists);

      // Navigate based on user existence
      return App(
        authRepository: authRepository,
        secureStorageRepository: secureStorageRepository,
        initialRoute: userExists ? '/home' : '/login',
        user: userData,
        messageRepository: messageRepository,
        hodBatchRepository: hodBatchRepository,
        sendUpdateMessageRepository: sendUpdateMessageRepository,
        dropdownRepository: dropdownRepository,
        batchRepository: batchRepository,
        semesterRepository: semesterRepository,
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authRepository,
    required this.messageRepository,
    required this.secureStorageRepository,
    required this.initialRoute,
    required this.user,
    required this.hodBatchRepository,
    required this.sendUpdateMessageRepository,
    required this.dropdownRepository,
    required this.batchRepository,
    required this.semesterRepository,
  }) : super(key: key);

  final AuthRepository authRepository;
  final SecureStorageRepository secureStorageRepository;
  final String initialRoute;
  final AuthUserModel? user;
  final MessageRepository messageRepository;
  final HodBatchRepository hodBatchRepository;
  final SendMessageRepository sendUpdateMessageRepository;
  final DropdownRepository dropdownRepository;
  final BatchRepository batchRepository;
  final SemesterRepository semesterRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: secureStorageRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SemesterBloc(getSemestersUseCase: GetSemestersUseCase(semesterRepository))),
          BlocProvider(create: (context) => ConnectivityBloc()),
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              signInUseCase: SignInUseCase(authRepository: authRepository),
              saveUserDataUseCase: SaveUserDataUseCase(secureStorageRepository),
            ),
          ),
          BlocProvider<SignOutBloc>(
            create: (context) => SignOutBloc(
              authRepository: authRepository,
              deleteUserDataUseCase:
                  DeleteUserDataUseCase(secureStorageRepository),
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              messageUseCase:
                  MessageUseCase(messageRepository: messageRepository),
            ),
          ),
          BlocProvider(
            create: (context) => StudentMessageBloc(
              messageUseCase:
              StudentMessageUseCase(),
            ),
          ),
          BlocProvider<MessageRemoveBloc>(
            create: (context) => MessageRemoveBloc(
                messageUseCase:
                    MessageUseCase(messageRepository: messageRepository)),
          ),
          BlocProvider<HodBatchBloc>(
            create: (context) => HodBatchBloc(
                fetchBatchIdsUseCase:
                    FetchBatchIdsUseCase(repository: hodBatchRepository)),
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
          ),
          BlocProvider<FileDownloadBloc>(
              create: (context) => FileDownloadBloc()),
          BlocProvider<StudentFileDownloadBloc>(
              create: (context) => StudentFileDownloadBloc()),
          BlocProvider<ToWhomOverlayCubit>(
              create: (context) => ToWhomOverlayCubit()),
          BlocProvider<AnnouncementBloc>(
              create: (context) => AnnouncementBloc(
                  sendUpdateMessageUseCase: SendUpdateMessageUseCase(
                      sendUpdateMessageRepository:
                          sendUpdateMessageRepository))),
          BlocProvider<CheckBoxBloc>(create: (context) => CheckBoxBloc()),
          BlocProvider<FilePickBloc>(
            create: (context) => FilePickBloc(),
          ),
          BlocProvider<BatchYearBloc>(
            create: (_) => BatchYearBloc(),
          ),
          BlocProvider<DropdownBloc>(
              create: (_) => DropdownBloc(
                  FetchDropdownItemsUseCase(repository: dropdownRepository))),
          BlocProvider<BatchCreationFilePickerBloc>(
              create: (_) => BatchCreationFilePickerBloc()),
          BlocProvider<BatchCreationBloc>(
              create: (_) => BatchCreationBloc(
                  validateExcelFileUseCase: ValidateExcelFileUseCase(
                      excelFileValidator: ExcelFileValidator()),
                  preprocessExcelUseCase: PreprocessExcelUseCase(),
                  pushBatchDataUseCase:
                      PushBatchDataUseCase(batchRepository: batchRepository),
                  batchYearCheckUseCase:
                      BatchYearCheckUseCase(batchRepository: batchRepository))),

          BlocProvider<MessageDetailsBloc>(create: (_) => MessageDetailsBloc()),
          BlocProvider<StudentMessageDetailsBloc>(create: (_) => StudentMessageDetailsBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Clean Architecture',
          theme: ThemeData.light(useMaterial3: true),
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const SignInView(),
            '/hod_space': (context) => HodSpacePage(user: user),
            '/student_space':(context)=> StudentSpacePage(user: user),
            '/home': (context) => NavigationScreen(user: user),
            '/hod_batch_creation_page': (context) => const BatchCreationPage(),

            '/hod_batch_course_details_page': (context) =>
                const HodBatchCourseDetailsPage(
                  batchId: '',
                ),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/hod_batch_page') {
              // Extract the batchId argument from the settings
              final args = settings.arguments as Map<String, dynamic>;
              final AuthUserModel? user = args['user'];
              final String batchId = args['batchId'];
              return MaterialPageRoute(
                builder: (context) {
                  return HodBatchPage(user: user, batchId: batchId);
                },
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
