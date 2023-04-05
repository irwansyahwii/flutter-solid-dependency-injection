import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_error.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_finished.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_cubit.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class SplashScreenLoading extends SplashScreenState {

  SplashScreenLoading({required SplashCubit cubit}){
    super.cubit = cubit;
  }
  
  @override
  Future<void> delayFinished() {
    return Future.value();
  }


  @override
  Future<void> loadingStepsThrowsError(Exception err) {
    return cubit!.changeState(DisplayLoadingError(cubit: cubit!, errorMessage: err.toString()));
  }

  @override
  Future<void> startLoading() {
    return Future.value();
  }
  
  @override
  Future<void> loadingStepsFinished(bool isUserLoggedIn, bool isErrorHappened, String errorMessage) {
    return cubit!.changeState(DisplayLoadingFinished(
      cubit: cubit!, 
      isUserLoggedIn: isUserLoggedIn, 
      isErrorHappened: isErrorHappened, 
      errorMessage: errorMessage));

  }

}