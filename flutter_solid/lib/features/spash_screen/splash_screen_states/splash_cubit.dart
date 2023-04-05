import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_error.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_finished.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_loading.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';
import 'package:flutter_solid/shared/services/delay_service.dart';

class SplashCubit extends Cubit<SplashScreenState> {
  final DelayService delayService;
  SplashCubit(super.initialState, {required this.delayService});

  Future<void> startLoading() async{    
    // await delayService.startDelay(const Duration(microseconds: 1));
    emit(SplashScreenLoading());
    await delayService.startDelay(const Duration(seconds: 3));

    loadingStepsFinished();
    // loadingStepsThrowsError(Exception("One or more error happened"));
  }


  loadingStepsFinished(){
    emit(DisplayLoadingFinished(isUserLoggedIn: false));
  }
  Future<void> loadingStepsThrowsError(Exception err)async {
    await delayService.startDelay(const Duration(microseconds: 1));
    emit(DisplayLoadingError(errorMessageValue: err.toString()));
    await delayService.startDelay(const Duration(microseconds: 1));
  }

  Future<void> startDelay() async {    
    await delayService.startDelay(const Duration(seconds: 2));

    delayFinished();
  }
  Future<void> startZeroDelay() async {
    delayFinished();
  }

  delayFinished()async{

    switch(state.runtimeType){
      case DisplayLoadingError:
        final loadingError = (state as DisplayLoadingError);
        await delayService.startDelay(const Duration(microseconds: 1));
        emit(SplashScreenFinalState(errorMessage: loadingError.errorMessageValue, isErrorHappened: true, isUserLoggedIn: false));
        await delayService.startDelay(const Duration(microseconds: 1));
        break;
      case DisplayLoadingFinished:
        final finishedState = (state as DisplayLoadingFinished);
        await delayService.startDelay(const Duration(microseconds: 1));
        emit(SplashScreenFinalState(errorMessage: '', isErrorHappened: false, isUserLoggedIn: finishedState.userLoggedIn));
        await delayService.startDelay(const Duration(microseconds: 1));
        break; 
    }
    
    
  }
}