import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class DisplayLoadingFinished extends SplashScreenState {
  final bool isUserLoggedIn;
  DisplayLoadingFinished({required this.isUserLoggedIn});

  get userLoggedIn{
    return isUserLoggedIn;
  }
}