import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_error.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_finished.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_loading.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class SplashCubit extends Cubit<SplashScreenState> {
  SplashCubit(super.initialState);

  Future<void> startLoading() async{
    await Future.delayed(const Duration(microseconds: 1));
    emit(SplashScreenLoading());
    await Future.delayed(const Duration(seconds: 3));

    loadingStepsFinished();
    // loadingStepsThrowsError(Exception("One or more error happened"));
  }


  loadingStepsFinished(){
    emit(DisplayLoadingFinished(isUserLoggedIn: false));
  }
  loadingStepsThrowsError(Exception err){
    emit(DisplayLoadingError(errorMessageValue: err.toString()));
  }

  Future<void> startDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    delayFinished();
  }
  Future<void> startZeroDelay() async {
    delayFinished();
  }

  delayFinished(){

    switch(state.runtimeType){
      case DisplayLoadingError:
        final loadingError = (state as DisplayLoadingError);
        emit(SplashScreenFinalState(errorMessage: loadingError.errorMessageValue, isErrorHappened: true, isUserLoggedIn: false));
        break;
      case DisplayLoadingFinished:
        final finishedState = (state as DisplayLoadingFinished);
        emit(SplashScreenFinalState(errorMessage: '', isErrorHappened: false, isUserLoggedIn: finishedState.userLoggedIn));
        break; 
    }
    
    
  }
}