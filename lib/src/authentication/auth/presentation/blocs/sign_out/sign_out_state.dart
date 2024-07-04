
abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutInProgress extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutFailure extends SignOutState {
  final String error;

  SignOutFailure(this.error);

  @override
  String toString() => 'SignOutFailure { error: $error }';
}
