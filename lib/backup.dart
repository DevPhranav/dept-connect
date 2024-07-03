// import 'package:connectivity_bloc/connectivity_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:miniproject_authentication/src/features/auth/data/models/auth_user_model.dart';
// import 'package:miniproject_authentication/src/features/auth/data/repositories/secure_storage_repository_impl.dart';
// import 'package:miniproject_authentication/src/features/auth/domain/use_cases/delete_user_data_usecase.dart';
// import 'package:miniproject_authentication/src/features/auth/domain/use_cases/save_user_data_usecase.dart';
// import 'package:miniproject_authentication/src/features/auth/domain/use_cases/sign_in_use_case.dart';
// import 'package:miniproject_authentication/src/features/auth/presentation/blocs/sign_in/sign_in_bloc.dart';
// import 'package:miniproject_authentication/src/features/auth/presentation/blocs/sign_out/sign_out_bloc.dart';
// import 'package:miniproject_authentication/src/features/auth/presentation/screens/sign_in_screen.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/data/data_source/drop_down_data_source_impl.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/data/repositories/dropDownRepositoryImpl.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/domain/repositories/DropDownRepository.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/domain/repositories/drop_down_data_source.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/presentation/bloc/batch_senior_tutor_select_bloc/batch_senior_tutor_dropdown_bloc.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/presentation/bloc/batch_year_bloc/batch_year_bloc.dart';
// import 'package:miniproject_authentication/src/features/batch_creation/presentation/screens/batch_creation_page.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/bloc/navigation/hod_navigation_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/data/datasource/firestore_data_source_impl.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/data/repositories/send_update_message_repo_impl.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/domain/repositories/FirestoreDataSource.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/domain/repositories/SendUpdateMessageRepository.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/domain/use_cases/send_update_message_use_case.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/presentation/bloc/announcement_page_blocs/announcement_check_box_bloc/check_box_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/presentation/bloc/announcement_page_blocs/announcement_send_bloc/announcement_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/presentation/bloc/announcement_page_blocs/file_upload_bloc/file_upload_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_announcement/presentation/screens/hod_batch_announcement_page.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/data/data_source/firestore_data_source_impl.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/data/repositories/MessageRepositoryImpl.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/domain/repositories/FirestoreDataSource.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/domain/repositories/MessageRepository.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/domain/usecases/message_usecase.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/announcement_details_full_screen_blocs/ToWhomCubit/to_whom_cubit.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/announcement_details_full_screen_blocs/file_download_bloc/file_download_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/stream_page_blocs/message_remove_bloc/message_remove_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/stream_page_blocs/message_show_bloc/message_show_bloc.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/others/stream/stream_main/presentation/bloc/stream_page_blocs/message_show_bloc/message_show_event.dart';
// import 'package:miniproject_authentication/src/features/hod_space/data/datasource/hod_remote_data_source_impl.dart';
// import 'package:miniproject_authentication/src/features/hod_space/data/repositories/hod_batch_repository_impl.dart';
// import 'package:miniproject_authentication/src/features/hod_space/domain/repositories/batch_remote_datasource.dart';
// import 'package:miniproject_authentication/src/features/hod_space/domain/repositories/hod_batch_repository.dart';
// import 'package:miniproject_authentication/src/features/hod_space/domain/usecase/fetch_batch_ids_use_case.dart';
// import 'package:miniproject_authentication/src/features/hod_space/presentation/blocs/hod_space/hod_batch_bloc.dart';
// import 'package:miniproject_authentication/src/features/auth/presentation/screens/splash_screen.dart';
// import 'package:miniproject_authentication/src/features/hod_batch/presentation/screens/hod_batch_page.dart';
// import 'package:miniproject_authentication/src/features/hod_space/presentation/screens/hod_space_page.dart';
// import 'package:miniproject_authentication/src/features/hod_space/presentation/screens/navigation_page.dart';
// import 'firebase_options.dart';
// import 'src/features/auth/data/data_sources/auth_remote_data_source.dart';
// import 'src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
// import 'src/features/auth/data/repositories/auth_repository_impl.dart';
// import 'src/features/auth/domain/repositories/auth_repository.dart';
// import 'src/features/auth/domain/repositories/secure_storage_repository.dart';
//
// typedef AppBuilder = Future<Widget> Function();
//
// Future<void> bootstrap(AppBuilder builder) async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Set preferred orientations to portrait mode only
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   runApp(const SplashScreen());
//   await Future.delayed(const Duration(seconds: 5));
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(await builder());
// }
//
// void main() {
//   bootstrap(
//         () async {
//       AuthRemoteDataSource authRemoteDataSource =
//       AuthRemoteDataSourceFirebase();
//       FirestoreDataSource firestoreDataSource = FirestoreDataSourceImpl();
//
//       AuthRepository authRepository = AuthRepositoryImpl(
//         remoteDataSource: authRemoteDataSource,
//       );
//
//       FlutterSecureStorage secureStorage = const FlutterSecureStorage();
//       SecureStorageRepository secureStorageRepository =
//       SecureStorageRepositoryImpl(secureStorage);
//       MessageRepository messageRepository =
//       MessageRepositoryImpl(firestoreDataSource);
//
//       HodBatchRemoteDataSource remoteDataSource =
//       HodBatchRemoteDataSourceImpl();
//       HodBatchRepository hodBatchRepository =
//       HodBatchRepositoryImpl(remoteDataSource: remoteDataSource);
//
//       FirestoreSendAndUpdateDataSource firestoreSendAndUpdateDataSource =
//       FirestoreSendAndUpdateDataSourceImpl();
//       SendUpdateMessageRepository sendUpdateMessageRepository =
//       SendUpdateMessageRepositoryImpl(
//           firestoreDataSource: firestoreSendAndUpdateDataSource);
//
//
//       // Check if user data exists in SecureStorage
//       final userData = await secureStorageRepository.getUserData();
//       final userExists = userData != null;
//
//
//
//       // Navigate based on user existence
//       return App(
//         authRepository: authRepository,
//         secureStorageRepository: secureStorageRepository,
//         initialRoute: userExists ? '/home' : '/login',
//         user: userData,
//         messageRepository: messageRepository,
//         hodBatchRepository: hodBatchRepository,
//         sendUpdateMessageRepository: sendUpdateMessageRepository,
//       );
//     },
//   );
// }
//
// class App extends StatelessWidget {
//   const App({
//     Key? key,
//     required this.authRepository,
//     required this.messageRepository,
//     required this.secureStorageRepository,
//     required this.initialRoute,
//     required this.user,
//     required this.hodBatchRepository,
//     required this.sendUpdateMessageRepository,
//   }) : super(key: key);
//
//   final AuthRepository authRepository;
//   final SecureStorageRepository secureStorageRepository;
//   final String initialRoute;
//   final AuthUserModel? user;
//   final MessageRepository messageRepository;
//   final HodBatchRepository hodBatchRepository;
//   final SendUpdateMessageRepository sendUpdateMessageRepository;
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider.value(value: authRepository),
//         RepositoryProvider.value(value: secureStorageRepository),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => ConnectivityBloc()),
//           BlocProvider<SignInBloc>(
//             create: (context) => SignInBloc(
//               signInUseCase: SignInUseCase(authRepository: authRepository),
//               saveUserDataUseCase: SaveUserDataUseCase(secureStorageRepository),
//             ),
//           ),
//           BlocProvider<SignOutBloc>(
//             create: (context) => SignOutBloc(
//               authRepository: authRepository,
//               deleteUserDataUseCase:
//               DeleteUserDataUseCase(secureStorageRepository),
//             ),
//           ),
//           BlocProvider(
//             create: (context) => MessageBloc(
//               messageUseCase:
//               MessageUseCase(messageRepository: messageRepository),
//             )..add(LoadMessagesEvent()),
//           ),
//           BlocProvider<MessageRemoveBloc>(
//             create: (context) => MessageRemoveBloc(
//                 messageUseCase:
//                 MessageUseCase(messageRepository: messageRepository)),
//           ),
//           BlocProvider<HodBatchBloc>(
//             create: (context) => HodBatchBloc(
//                 fetchBatchIdsUseCase:
//                 FetchBatchIdsUseCase(repository: hodBatchRepository)),
//           ),
//           BlocProvider<NavigationBloc>(
//             create: (context) => NavigationBloc(),
//           ),
//           BlocProvider<FileDownloadBloc>(
//               create: (context) => FileDownloadBloc()),
//           BlocProvider<ToWhomOverlayCubit>(
//               create: (context) => ToWhomOverlayCubit()),
//           BlocProvider<AnnouncementBloc>(
//               create: (context) => AnnouncementBloc(
//                   sendRemoveMessageUseCase: SendUpdateMessageUseCase(
//                       sendUpdateMessageRepository:
//                       sendUpdateMessageRepository))),
//           BlocProvider<CheckBoxBloc>(create: (context) => CheckBoxBloc()),
//           BlocProvider<FilePickBloc>(
//             create: (context) => FilePickBloc(),
//           ),
//           BlocProvider<BatchYearBloc>( create: (_) => BatchYearBloc(),),
//           BlocProvider<DropdownBloc>(create:(_) => DropdownBloc(fetchDropdownItems: )),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Clean Architecture',
//           theme: ThemeData.light(useMaterial3: true),
//           initialRoute: initialRoute,
//           routes: {
//             '/login': (context) => const SignInView(),
//             '/hod_space': (context) => HodSpacePage(user: user),
//             '/home': (context) => NavigationScreen(user: user),
//             '/hod_batch_creation_page' : (context) => const BatchCreationPage(),
//             '/hod_batch_announcement_page': (context) {
//               final args = ModalRoute.of(context)!.settings.arguments as String;
//               return HodBatchAnnouncementPage(batchId: args);
//             }
//           },
//           onGenerateRoute: (settings) {
//             if (settings.name == '/hod_batch_page') {
//               // Extract the batchId argument from the settings
//               final args = settings.arguments as Map<String, dynamic>;
//               final AuthUserModel? user = args['user'];
//               final String batchId = args['batchId'];
//               return MaterialPageRoute(
//                 builder: (context) {
//                   return HodBatchPage(user: user, batchId: batchId);
//                 },
//               );
//             }
//             return null;
//           },
//         ),
//       ),
//     );
//   }
// }
