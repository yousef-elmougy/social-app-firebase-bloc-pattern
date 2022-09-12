part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}


class CreateUserLoading extends UserState {}
class CreateUserLoaded extends UserState {}
class CreateUserError extends UserState {
  final String error;

  CreateUserError(this.error);
}

class UpdateUserLoading extends UserState {}
class UpdateUserLoaded extends UserState {}
class UpdateUserError extends UserState {
  final String error;

  UpdateUserError(this.error);
}

/// GET USERS
class GetUserLoading extends UserState{}
class GetUserLoaded extends UserState{

}
class GetUserError extends UserState{
  final String error;

  GetUserError(this.error);
}
/// GET ALL USERS
class GetAllUsersLoading extends UserState{}
class GetAllUsersLoaded extends UserState{

}
class GetAllUsersError extends UserState{
  final String error;

  GetAllUsersError(this.error);
}
/// SIGN OUT
class SignOutLoading extends UserState{}
class SignOutLoaded extends UserState{

}
class SignOutError extends UserState{
  final String error;

  SignOutError(this.error);
}

class PickedCover extends UserState {}
class PickedCircle extends UserState {}

class UploadCircleImage extends UserState {}
class UploadCoverImage extends UserState {}


class UploadImageLoading extends UserState {}

