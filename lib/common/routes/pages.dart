import 'package:chatl1/common/routes/names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../pages/welcome/index.dart';
import '../../pages/sign_in/index.dart';
import '../../pages/register/index.dart';
import '../../pages/application/index.dart';
import '../middleware/auth_middleware.dart';


class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObserver();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.Application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
  ];
}