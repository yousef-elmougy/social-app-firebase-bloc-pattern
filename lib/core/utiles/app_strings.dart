import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app_firebase/features/features_exports.dart';
import 'package:social_app_firebase/injection_container.dart' as di;

class AppStrings {
  static const String themeKey = 'CACHED_THEME';
  static const String localeKey = 'CACHE_LOCALE';
  static const String userKey = 'CACHE_USER';
  static const String uIdKey = 'CACHE_USER_ID';
  static const String postKey = 'CACHE_POST';

  static String uId = FirebaseAuth.instance.currentUser!.uid;

  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String offlineFailure = 'Offline Failure';
  static const String firebaseFailure = 'Firebase Failure';
  static const String unExpectedError = 'Un Expected Error';

  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
}
