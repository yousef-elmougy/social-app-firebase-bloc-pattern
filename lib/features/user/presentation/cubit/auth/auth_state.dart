part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


/// REGISTER

class RegisterLoading extends AuthState {}
class RegisterLoaded extends AuthState {}
class RegisterError extends AuthState {
  final String error;

  RegisterError(this.error);
}


class LoginLoading extends AuthState {}
class LoginLoaded extends AuthState {}
class LoginError extends AuthState {
  final String error;

  LoginError(this.error);
}

/// SIGN OUT
class SignOutLoading extends AuthState{}
class SignOutLoaded extends AuthState{

}
class SignOutError extends AuthState{
  final String error;

  SignOutError(this.error);
}


class ChangeVisibility extends AuthState {
  final bool isVisible;

  ChangeVisibility(this.isVisible);

}

