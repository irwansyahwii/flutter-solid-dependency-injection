import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class SplashScreenFinalState extends SplashScreenState {
  final bool isUserLoggedIn;
  final bool isErrorHappened;
  final String errorMessage;
  SplashScreenFinalState({required this.isUserLoggedIn, required this.isErrorHappened, required this.errorMessage});
  
  @override
  Future<void> delayFinished() {
    return Future.value();
  }
  
  
  @override
  Future<void> loadingStepsThrowsError(Exception err) {
    return Future.value();
  }
  
  @override
  Future<void> startLoading() {
    return Future.value();
  }
  
  @override
  Future<void> loadingStepsFinished(bool isUserLoggedIn, bool isErrorHappened, String errorMessage) {
    return Future.value();
  }

}