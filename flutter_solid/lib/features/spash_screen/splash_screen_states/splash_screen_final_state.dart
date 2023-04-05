import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class SplashScreenFinalState extends SplashScreenState {
  final bool isUserLoggedIn;
  final bool isErrorHappened;
  final String errorMessage;
  SplashScreenFinalState({required this.isUserLoggedIn, required this.isErrorHappened, required this.errorMessage});

  get userLoggedIn{
    return isUserLoggedIn;
  }

  get errorHappened{
    return isErrorHappened;
  }

  get messageError {
    return errorMessage;
  }
}