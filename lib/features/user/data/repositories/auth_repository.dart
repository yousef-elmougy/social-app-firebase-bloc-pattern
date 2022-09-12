import 'package:dartz/dartz.dart';

import 'package:social_app_firebase/features/features_exports.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> register({String? password, email});

  Future<Either<Failure, UserCredential>> login({String? password, email});

}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authRemoteDataSource,
    required this.networkInfo});

  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  /// REGISTER

  @override
  Future<Either<Failure, UserCredential>> register(
      {String? password, email}) async {
    if (await networkInfo.isConnected) {
      try {
        UserCredential registerCredential = await authRemoteDataSource.register(
            email: email, password: password);
        return Right(registerCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return Left(FirebaseFailure('The password provided is too weak.'));
        } else if (e.code == 'email-already-in-use') {
          return Left(
              FirebaseFailure('The account already exists for that email.'));
        } else {
          return Left(FirebaseFailure(e.toString()));
        }
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  /// LOGIN

  @override
  Future<Either<Failure, UserCredential>> login(
      {String? password, email}) async {
    if (await networkInfo.isConnected) {
      try {
        UserCredential loginCredential =
        await authRemoteDataSource.login(password: password, email: email);
        return Right(loginCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return Left(FirebaseFailure('No user found for that email.'));
        } else if (e.code == 'wrong-password') {
          return Left(
              FirebaseFailure('Wrong password provided for that user.'));
        } else {
          return Left(FirebaseFailure(e.toString()));
        }
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
