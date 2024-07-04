import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/use_cases/delete_user_data_usecase.dart';
import 'sign_out_event.dart';
import 'sign_out_state.dart';


class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final AuthRepository authRepository;
  final DeleteUserDataUseCase deleteUserDataUseCase;

  SignOutBloc({required this.authRepository,required this.deleteUserDataUseCase}) : super(SignOutInitial()) {
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<SignOutState> emit) async {
    emit(SignOutInProgress());
    try {
      await authRepository.signOut();
      await deleteUserDataUseCase.execute();
      emit(SignOutSuccess());
    } catch (e) {
      emit(SignOutFailure(e.toString()));
    }
  }
}
