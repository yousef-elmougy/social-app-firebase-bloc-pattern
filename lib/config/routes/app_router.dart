import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app_firebase/auth_state_changes.dart';
import 'package:social_app_firebase/config/routes/routes.dart';
import 'package:social_app_firebase/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:social_app_firebase/features/user/data/models/user_model.dart';
import '../../core/utiles/app_strings.dart';
import '../../features/post/presentation/screens/create_post_screen.dart';
import '../../features/user/presentation/screens/auth/login_screen.dart';
import '../../features/layout/layout_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'package:social_app_firebase/injection_container.dart' as di;

import '../../features/user/presentation/screens/auth/register_screen.dart';
import '../../features/user/presentation/screens/settings/settings_edit_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // /// SPLASH SCREEN
      // case Routes.splashScreen:
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// LOGIN SCREEN
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) =>
                const AuthStateChangesScreen(authWidget: LoginScreen()));

      /// REGISTER SCREEN
      case Routes.registerScreen:
        return MaterialPageRoute(
            builder: (_) =>
                const AuthStateChangesScreen(authWidget: RegisterScreen()));

      /// NEW POST SCREEN
      case Routes.newPostScreenScreen:
        return MaterialPageRoute(builder: (_) => const NewPostScreen());

      /// SETTINGS EDIT SCREEN
      case Routes.settingsEditScreenScreen:
        return MaterialPageRoute(builder: (_) => const SettingsEditScreen());

      /// CHAT DETAILS SCREEN
      case Routes.chatDetailsScreen:
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => ChatDetailsScreen(userModel: userModel));

      default:
        return _defaultRoute();
    }
  }

  static MaterialPageRoute<dynamic> _defaultRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('ERROR : Route Not Found')),
          body: const Center(
            child: Text(
              'ERROR : Route Not Found',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );
}
