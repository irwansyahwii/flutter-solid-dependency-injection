import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_loading.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class SplashScreenStart extends SplashScreenState{
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
    return cubit!.changeState(SplashScreenLoading(cubit: cubit!));
  }
  
  @override
  Future<void> loadingStepsFinished(bool isUserLoggedIn, bool isErrorHappened, String errorMessage) {
    return Future.value();
  }
  
}