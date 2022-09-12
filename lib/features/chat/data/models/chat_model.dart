
class ChatModel {
  final String? senderId, text, chatImage, receiverId;
  final DateTime? dateTime;

  ChatModel({
    this.senderId,
    this.chatImage,
    this.receiverId,
    this.dateTime,
    this.text,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatImage: json['chatImage'],
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        dateTime: json['dateTime'].toDate(),
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'chatImage': chatImage,
        'receiverId': receiverId,
        'senderId': senderId,
        'dateTime': dateTime,
        'text': text,
      };
}
