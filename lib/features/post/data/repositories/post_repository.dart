import 'package:dartz/dartz.dart';
import '../../../user/data/models/user_model.dart';

import 'package:social_app_firebase/features/features_exports.dart';

abstract class PostRepository {
  Future<Either<Failure, void>> createPost(
      {String? text,String? postImage,String? postId, DateTime? dateTime, UserModel? userModel});

  Stream<QuerySnapshot<Map<String, dynamic>>> getPost();

}

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(
      {required this.networkInfo, required this.postRemoteDataSource});

  final PostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, void>> createPost({String? text,
    String?  postImage,
    String? postId,
    DateTime? dateTime,
    UserModel? userModel}) async =>
      Methods().handleRepoException(
        networkInfo,
        data: postRemoteDataSource.createNewPost(
          userModel: userModel,
          postImage: postImage,
          dateTime: dateTime,
          text: text,
          postId: postId,
        ),
      );

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPost() =>
      postRemoteDataSource.getPosts();

}