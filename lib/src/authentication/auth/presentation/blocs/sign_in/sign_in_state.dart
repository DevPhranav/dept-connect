import 'package:equatable/equatable.dart';
import '../../../data/models/auth_user_model.dart';
import '../../../domain/entities/auth_user.dart';


class SignInState extends Equatable {
  final String? email;
  final String? password;
  final String userType;

  const SignInState({
    this.email,
    this.password,
    this.userType = '',
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? userType,
    AuthUser? user,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    userType,
  ];


}


class SignInLoadingState extends SignInState{}

class SignInSuccessState extends SignInState{
  final AuthUserModel user;

  const SignInSuccessState({required this.user});

}

class SignInFailureState extends SignInState{
  final String errorMessage;

  const SignInFailureState({required this.errorMessage});
}


