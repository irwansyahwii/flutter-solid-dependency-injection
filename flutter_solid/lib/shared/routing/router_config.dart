import 'package:flutter/cupertino.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen(key: Key('splash-screen'));
      },
    )
  ]
);