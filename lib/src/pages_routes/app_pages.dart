import 'package:app_greengrocer/src/base/base_page.dart';
import 'package:app_greengrocer/src/pages/sign/signPage.dart';
import 'package:app_greengrocer/src/pages/sign/sign_up_page.dart';
import 'package:app_greengrocer/src/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      page: () => const SplashScreen(),
      name: PagesRoutes.splashRoute,
    ),

    GetPage(
      page: () => const SignPage(),
      name: PagesRoutes.signInRoute,
    ),


    GetPage(
      page: () => SignUpPage(),
      name: PagesRoutes.signUpRoute,
    ),

    GetPage(
      page: () => const BasePage(),
      name: PagesRoutes.baseRoute,
    ),


  ];
}

abstract class PagesRoutes{
    static const String splashRoute = '/splash';
    static const String signInRoute = '/signin';
    static const String signUpRoute = '/signUp';
    static const String baseRoute = '/';
}
