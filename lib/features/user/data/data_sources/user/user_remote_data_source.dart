import '../../models/user_model.dart';
import 'package:social_app_firebase/features/features_exports.dart';

abstract class UserRemoteDataSource {
  Future<void> createUser({String? name, phone, email, uId});

  Future<void> updateUser({String? name, phone, email, bio, image, cover, uId});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String? uId);

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<void> createUser({String? name, phone, email, uId}) async {
    UserModel userModel = UserModel(
      uId: uId,
      phone: phone,
      email: email,
      name: name,
      image:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      bio: 'write something...',
      cover:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    );

    void firebaseFirestore = await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson());
    return firebaseFirestore;
  }

  @override
  Future<void> updateUser(
      {String? name, phone, email, bio, image, cover, uId}) async {
    UserModel userModel = UserModel(
        phone: phone,
        email: email,
        name: name,
        bio: bio,
        uId: uId,
        image: image,
        cover: cover);

    void firebaseFirestore = await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson());
    return firebaseFirestore;
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String? uId) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .snapshots(includeMetadataChanges: true);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .snapshots(includeMetadataChanges: true);
}
