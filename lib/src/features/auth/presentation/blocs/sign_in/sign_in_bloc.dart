import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/auth_user_model.dart';
import '../../../domain/use_cases/sign_in_use_case.dart';
import '../../../domain/use_cases/save_user_data_usecase.dart'; // Import the SaveUserDataUseCase
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;


  SignInBloc({
    required SignInUseCase signInUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
  })  : _signInUseCase = signInUseCase,
        _saveUserDataUseCase = saveUserDataUseCase,
        super(const SignInState()) {
    on<SignInInitialEvent>(_onSignInInitialed);
    on<UserTypeChanged>(_onUserTypeChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  void _onSignInInitialed(SignInInitialEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(
      email: '',
      password: '',
      userType: '',
    ));
  }

  void _onUserTypeChanged(UserTypeChanged event, Emitter<SignInState> emit) {
    emit(state.copyWith(userType: event.userType));
  }

  Future<void> _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    final email = event.email;
    final password = event.password;
    final userType = event.userType;
      try {
        emit(SignInLoadingState());
        final authUser = await _signInUseCase(
          SignInParams(
            email: email,
            password: password,
            userType: userType,
          ),
        );
        final authModel = AuthUserModel(id: authUser.id, email: authUser.email, department: authUser.department);

        // Save user data after successful sign-in
        await _saveUserDataUseCase.execute(
          email: email,
          id: authUser.id,
          department: authUser.department,
        );

        emit(SignInSuccessState(user: authModel));
      } catch (e) {
        emit(SignInFailureState(errorMessage: e.toString()));
      }
    }
  }

