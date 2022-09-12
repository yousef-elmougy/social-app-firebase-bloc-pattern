import '../../../features_exports.dart';

class PostModel {
  final String? name, uId, image, text, postImage, postId;
  final List? likes;
  final DateTime? dateTime;

  PostModel({
    this.postId,
    this.likes,
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        name: json['name'],
        uId: json['uId'],
        image: json['image'],
        dateTime: json['dateTime'].toDate(),
        text: json['text'],
        postImage: json['postImage'],
        likes: json['likes'],
        postId: json['postId'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'uId': uId,
        'image': image,
        'dateTime': dateTime,
        'text': text,
        'postImage': postImage,
        'likes': likes,
        'postId': postId,
      };
}
