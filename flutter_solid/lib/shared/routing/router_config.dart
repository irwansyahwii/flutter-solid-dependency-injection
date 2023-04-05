import 'package:flutter/cupertino.dart';
import 'package:flutter_solid/features/loading_error_screen/loading_error_screen.dart';
import 'package:flutter_solid/features/login_screen/login_screen.dart';
import 'package:flutter_solid/features/main_screen/main_screen.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen(key: Key('splash-screen'));
      },
    ),
    GoRoute(
      path: '/loginscreen',
      builder: (context, state) {
        return const LoginScreen(key: Key('login-screen'));
      },
    ),
    GoRoute(
      path: '/mainscreen',
      builder: (context, state) {
        return const MainScreen(key: Key('main-screen'));
      },
    ),
    GoRoute(
      path: '/loadingerrorscreen',
      builder: (context, state) {
        return const LoadingErrorScreen(key: Key('loading-error-screen'));
      },
    )

  ]
);