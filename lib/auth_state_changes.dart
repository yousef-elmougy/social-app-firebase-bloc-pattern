import 'package:social_app_firebase/features/features_exports.dart';
import 'package:social_app_firebase/features/layout/layout_screen.dart';

class AuthStateChangesScreen extends StatelessWidget {
  const AuthStateChangesScreen({super.key, required this.authWidget});

  final Widget authWidget;

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.hasData ? const LayoutScreen() : authWidget;
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        },
      );
}
