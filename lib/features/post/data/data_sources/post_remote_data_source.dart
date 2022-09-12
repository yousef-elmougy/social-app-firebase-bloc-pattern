import 'package:social_app_firebase/features/user/data/models/user_model.dart';
import 'package:social_app_firebase/features/features_exports.dart';

abstract class PostRemoteDataSource {
  Future<void> createNewPost(
      {String? text,String? postImage,String? postId,DateTime ?dateTime, UserModel? userModel});

  // Future<void> updatePost(
  //     {String? name,
  //     String? phone,
  //     String? email,
  //     String? bio,
  //     String? uId,
  //     String? image,
  //     String? cover});

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts();

}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  @override
  Future<void> createNewPost(
      {String? text,String? postImage,String? postId,DateTime ?dateTime, UserModel? userModel}) async {
    PostModel postModel = PostModel(
      uId: userModel?.uId,
      name: userModel?.name,
      image: userModel?.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
      likes: [],
      postId:postId,
    );

    void firebaseFirestore = await FirebaseFirestore.instance
        .collection('posts').doc(postId)
        .set(postModel.toJson());
    return firebaseFirestore;
  }

  @override
 Stream<QuerySnapshot<Map<String, dynamic>>> getPosts()  =>
       FirebaseFirestore.instance
          .collection('posts')
          .orderBy('dateTime', descending: true)
          .snapshots(includeMetadataChanges: true);


}
