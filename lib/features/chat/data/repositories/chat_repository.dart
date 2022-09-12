import 'package:dartz/dartz.dart';
import 'package:social_app_firebase/features/features_exports.dart';


abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(
      {String? text, chatImage, receiverId, senderId, DateTime? dateTime});

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage({String? receiverId, senderId});
}

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(
      {required this.networkInfo, required this.chatRemoteDataSource});

  final ChatRemoteDataSource chatRemoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> sendMessage(
          {String? text,
          chatImage,
          receiverId,
          senderId,
          DateTime? dateTime}) async =>
      Methods().handleRepoException(
        networkInfo,
        data: chatRemoteDataSource.sendMessage(
          chatImage: chatImage,
          receiverId: receiverId,
          senderId: senderId,
          dateTime: dateTime,
          text: text,
        ),
      );

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage({String? receiverId, senderId}) =>
      chatRemoteDataSource.getMessage(receiverId: receiverId,senderId: senderId);
}
