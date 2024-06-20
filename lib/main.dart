import 'package:firebase_core/firebase_core.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie_dovie/src/presentation/providers/language_change_controller.dart';
import 'package:movie_dovie/src/screens/login_screen.dart/login_screen.dart';
import 'package:movie_dovie/src/screens/on_boarding_screen/onboarding_screen.dart';
import 'package:movie_dovie/src/screens/tabbar/bottom_tabbar.dart';
import 'package:provider/provider.dart' as provider;
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('language_code') ?? "";
  runApp(ProviderScope(
    child: MovieDovie(
      locale: languageCode,
    ),
  ));
}

class MovieDovie extends StatelessWidget {
  final String locale;
  const MovieDovie({
    super.key,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider<AppLanguage>(
              create: (_) => AppLanguage()),
        ],
        child: provider.Consumer<AppLanguage>(
            builder: (context, appLanguage, child) {
          if (appLanguage.appLocale == null) {
            appLanguage.fetchLocale();
            if (locale.isEmpty) {
              appLanguage.changeLanguage(const Locale('en'));
            } else {
              appLanguage.changeLanguage(Locale(locale));
            }
          }
          return Flexify(
            designHeight: 812,
            designWidth: 375,
            app: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: OnBoardingScreen(),
              locale: locale == ''
                  ? const Locale('en')
                  : appLanguage.appLocale == null
                      ? Locale(locale)
                      : appLanguage.appLocale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              supportedLocales: const [
                Locale("az"),
                Locale("en"),
                Locale("ru"),
              ],
              theme: ThemeData.light().copyWith(
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent),
              ),
              darkTheme: ThemeData.dark().copyWith(
                bottomSheetTheme: const BottomSheetThemeData(
                    backgroundColor: Colors.transparent),
              ),
              navigatorKey: Get.key,
              onGenerateRoute: (settings) {
                return GetPageRoute(
                  settings: settings,
                  page: () {
                    switch (settings.name) {
                      case '/login':
                        return LoginScreen();
                      case '/onboarding':
                        return OnBoardingScreen();
                      case '/bottomNavbar':
                        return BottomTabbar();
                      default:
                        return OnBoardingScreen();
                    }
                  },
                );
              },
            ),
          );
        }));
  }
}
