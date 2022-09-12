part of 'posts_cubit.dart';

@immutable
abstract class PostState  {}

class PostsInitial extends PostState {}


class CreatePostLoaded extends PostState{}
class CreatePostLoading extends PostState{}
class CreatePostError extends PostState{
  final String error;

  CreatePostError(this.error);
}

class GetPostLoaded extends PostState{}
class GetPostLoading extends PostState{}
class GetPostError extends PostState{
  final String error;

  GetPostError(this.error);
}

class GetPostIdLoaded extends PostState{}
class GetPostIdLoading extends PostState{}
class GetPostIdError extends PostState{
  final String error;

  GetPostIdError(this.error);
}


class PostsLike extends PostState{}
class PostsUnLike extends PostState{}


class PickPostImage extends PostState {}

class UploadPostImageLoading extends PostState {}

class UploadPostImageLoaded extends PostState {}

class ClearImage extends PostState {}

