import 'package:social_app_firebase/features/features_exports.dart';

abstract class AuthRemoteDataSource {

  Future<UserCredential> register({String? password, String? email});

  Future<UserCredential> login({String? password, String? email});
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  @override
  Future<UserCredential> register({String? password, String? email}) async =>
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

  @override
  Future<UserCredential> login({String? password, String? email}) async =>
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

}
