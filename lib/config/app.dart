
import 'package:social_app_firebase/features/chat/presentation/cubit/chat_cubit.dart';

import '../injection_container.dart' as di;
import 'package:social_app_firebase/features/features_exports.dart';

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<ThemeCubit>()),
          BlocProvider(create: (context) => di.sl<LocaleCubit>()),
          BlocProvider(create: (context) => di.sl<LayoutCubit>()),
          BlocProvider(create: (context) => di.sl<AuthCubit>()),
          BlocProvider(create: (context) => di.sl<UserCubit>()),
          BlocProvider(create: (context) => di.sl<PostCubit>()),
          BlocProvider(create: (context) => di.sl<ChatCubit>()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) => MaterialApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            theme: AppTheme.light,
            debugShowCheckedModeBanner: false,
            locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              for (Locale supportedLocale in supportedLocales) {
                if (locale != null &&
                    supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.last;
            },
          ),
        ),
      );
}
