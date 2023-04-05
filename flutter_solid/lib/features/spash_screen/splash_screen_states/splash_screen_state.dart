

import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_cubit.dart';

abstract class SplashScreenState {
  SplashCubit? cubit;
  
  Future<void> startLoading();
  Future<void> loadingStepsFinished(bool isUserLoggedIn, bool isErrorHappened, String errorMessage);
  Future<void> loadingStepsThrowsError(Exception err);
  Future<void> delayFinished();
}