import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_cubit.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class DisplayLoadingFinished extends SplashScreenState {
  final bool isUserLoggedIn;
  final bool isErrorHappened;
  final String errorMessage;
  DisplayLoadingFinished({required SplashCubit cubit, 
    required this.isUserLoggedIn,
    required this.isErrorHappened,
    required this.errorMessage}){
    super.cubit = cubit;
  }

  get userLoggedIn{
    return isUserLoggedIn;
  }
  
  @override
  Future<void> delayFinished() {
    return cubit!.changeState(SplashScreenFinalState(
      isUserLoggedIn: isUserLoggedIn, 
      isErrorHappened: isErrorHappened, 
      errorMessage: errorMessage));
    
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