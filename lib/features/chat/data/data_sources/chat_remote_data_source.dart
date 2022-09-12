import 'package:social_app_firebase/features/features_exports.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage(
      {String? text, chatImage, receiverId, senderId, DateTime? dateTime});

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      {String? receiverId, senderId});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<void> sendMessage(
      {String? text,
      chatImage,
      receiverId,
      senderId,
      DateTime? dateTime}) async {
    ChatModel chatModel = ChatModel(
      text: text,
      dateTime: dateTime,
      chatImage: chatImage ?? '',
      receiverId: receiverId,
      senderId: senderId,
    );

    // ADD MY CHAT
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(chatModel.toJson());

    // ADD RECEIVER CHAT
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(senderId)
        .collection('messages')
        .add(chatModel.toJson());
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
          {String? receiverId, senderId}) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('chat')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots(includeMetadataChanges: true);
}
