import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInInitialEvent extends SignInEvent{}

class UserTypeChanged extends SignInEvent{
  final String userType;

  const UserTypeChanged(this.userType);
  @override
  List<Object> get props => [userType];

}

class SignInBackToPageEvent extends SignInEvent{}

class SignInSubmitted extends SignInEvent {
  final String email;
  final String password;
  final String userType;

  const SignInSubmitted({required this.email, required this.password, required this.userType});

}
