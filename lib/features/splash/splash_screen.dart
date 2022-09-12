import 'package:social_app_firebase/features/features_exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startDelay() => _timer = Timer(
        const Duration(milliseconds: 2000),
        () => Routes.loginScreen.goToReplace(context),
      );

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Image.asset(ImgAssets.splashImage)));
}
