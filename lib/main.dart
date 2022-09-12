
import 'injection_container.dart' as di;
import 'package:social_app_firebase/features/features_exports.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();

  Bloc.observer = MyBlocObserver();
  runApp(const SocialApp());
  debugPrint(AppStrings.uId);

}


// class RestartWidget extends StatefulWidget {
//   const RestartWidget({super.key, required this.child});
//
//   final Widget ?child;
//
//
//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<RestartWidgetState>()?.restartApp();
//   }
//
//   @override
//   RestartWidgetState createState() => RestartWidgetState();
// }
//
// class RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();
//
//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: key,
//       child: widget.child ?? const SizedBox(),
//     );
//   }
// }



/*{
  "homePage": "الصفحة الرئيسية",
  "personalInformation": "معلومات شخصية",
  "nameHint": "أدخل أسمك",
  "email": "البريد الإلكتروني",
  "emailHint": "أدخل بريدك الالكتروني",
  "dateOfBirth": "تاريخ الولادة",
  "submitInfo": "إرسال معلومات",
  "aboutUs": "معلومات عنا",
  "settings": "الإعدادات",
  "changeLanguage": "تغيير اللغة",
  "about": "لوريم إيبسوم(Lorem Ipsum) هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر. كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس عشر عندما قامت مطبعة مجهولة برص مجموعة من الأحرف بشكل عشوائي أخذتها من نص، لتكوّن كتيّب بمثابة دليل أو مرجع شكلي لهذه الأحرف. خمسة قرون من الزمن لم تقضي على هذا النص، بل انه حتى صار مستخدماً وبشكله الأصلي في الطباعة والتنضيد الإلكتروني. انتشر بشكل كبير في ستينيّات هذا القرن مع إصدار رقائق 'ليتراسيت' (Letraset) البلاستيكية تحوي مقاطع من هذا النص، وعاد لينتشر مرة أخرى مؤخراَ مع ظهور برامج النشر الإلكتروني مثل 'ألدوس بايج مايكر' (Aldus PageMaker) والتي حوت أيضاً على نسخ من نص لوريم إيبسوم."
}*/






