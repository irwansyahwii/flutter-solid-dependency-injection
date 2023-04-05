import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_cubit.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class DisplayLoadingError extends SplashScreenState{
   final String errorMessage;

   DisplayLoadingError({required SplashCubit cubit, required this.errorMessage}){
    super.cubit = cubit;
   }
   
  @override
  Future<void> delayFinished() {
    return cubit!.changeState(SplashScreenFinalState(
      isUserLoggedIn: false, 
      isErrorHappened: true, errorMessage: errorMessage));
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