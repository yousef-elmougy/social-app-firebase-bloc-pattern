import 'package:dartz/dartz.dart';
import '../data_sources/user/user_remote_data_source.dart';
import 'package:social_app_firebase/features/features_exports.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> createUser({String? name, phone, email, uId});

  Future<Either<Failure, void>> updateUser(
      {String? name, phone, email, bio, image, cover, uId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String? uId);

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers();
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
      {required this.userRemoteDataSource, required this.networkInfo});

  final UserRemoteDataSource userRemoteDataSource;
  final NetworkInfo networkInfo;

  /// CREATE USER

  @override
  Future<Either<Failure, void>> createUser(
          {String? name, phone, email, uId}) async =>
      Methods().handleRepoException(networkInfo,
          data: userRemoteDataSource.createUser(
              uId: uId, phone: phone, email: email, name: name));

  @override
  Future<Either<Failure, void>> updateUser(
          {String? name, phone, email, bio, image, cover, uId}) async =>
      Methods().handleRepoException(networkInfo,
          data: userRemoteDataSource.updateUser(
            uId: uId,
            phone: phone,
            email: email,
            name: name,
            bio: bio,
            cover: cover,
            image: image,
          ));

  /// GET USER

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String? uId) =>
      userRemoteDataSource.getUser(uId);

  /// GET ALL USER

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      userRemoteDataSource.getAllUsers();
}
