
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../network/network_info.dart';
import 'app_strings.dart';

class Methods{

  /// ERROR HANDLER

  String mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offlineFailure;
      case FirebaseFailure:
        final FirebaseFailure firebaseFailure = failure as FirebaseFailure;
        return firebaseFailure.error.toString();

      default:
        return AppStrings.unExpectedError;
    }
  }

  /// HANDLE REPOSITORY INTERNET AND EXCEPTIONS

  Future<Either<Failure, T>> handleRepoException<T>(NetworkInfo networkInfo,
      {T? data}) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(data as T);
      } on ServerException {
        return Left(ServerFailure());
      } on FirebaseException catch (e) {
        return Left(FirebaseFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Uint8List?> pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        return await file.readAsBytes();
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    return null;
  }

  Future<String> uploadImageToStorage(
      {String? childName, Uint8List? file, bool? isPost}) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(childName!)
        .child(FirebaseAuth.instance.currentUser!.uid);

    if (isPost == true) {
      ref = ref.child(const Uuid().v1());
    }
    UploadTask uploadTask = ref.putData(file!);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}