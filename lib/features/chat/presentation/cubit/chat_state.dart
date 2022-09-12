part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

/// SEND MESSAGE
class SendMessageLoading extends ChatState {}

class SendMessageLoaded extends ChatState {}

class SendMessageError extends ChatState {
  final String error;

  SendMessageError(this.error);
}

/// GET MESSAGE
class GetMessageLoading extends ChatState {}

class GetMessageLoaded extends ChatState {}

/// PICK IMAGE
class PickChatImage extends ChatState {}

/// UPLOAD IMAGE
class UploadChatImageLoading extends ChatState {}

class UploadChatImageLoaded extends ChatState {}

class UploadChatImageError extends ChatState {}

/// CLEAR IMAGE
class ClearImage extends ChatState {}
