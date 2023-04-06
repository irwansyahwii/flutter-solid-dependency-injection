import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/services/app_loading_service.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_error.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_finished.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_loading.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_start.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';
import 'package:flutter_solid/shared/services/delay_service.dart';

class SplashCubit extends Cubit<SplashScreenState> {
  final DelayService delayService;
  final AppLoadingService appLoadingService;
  SplashCubit(super.initialState, {required this.delayService, required this.appLoadingService}){
    state.cubit = this;
    state.startLoading();
  }


  Future<void> changeState(SplashScreenState newState){
    emit(newState);

    switch(newState.runtimeType){
      case SplashScreenStart:
        return onSplashScreenStart();
      case SplashScreenLoading:
        return onSplashScreenLoading();
      case DisplayLoadingFinished:
        return onDisplayLoadingFinished();
      case DisplayLoadingError:
        return onDisplayLoadingError();        
      default:
        return Future.delayed(const Duration(microseconds: 100));
    }
  }  

  Future<void> onDisplayLoadingError(){
    return state.delayFinished();
  }

  Future<void> onDisplayLoadingFinished() async {
    await delayService.startDelay(const Duration(seconds: 1));
    return state.delayFinished();
  }

  Future<void> onSplashScreenLoading() async{
    try {
      await appLoadingService.run();

      await state.loadingStepsFinished(
        appLoadingService.isUserLoggedIn,
        appLoadingService.isErrorHappened,
        appLoadingService.errorMessage);
      
    } catch (e) {
      state.loadingStepsThrowsError(Exception(e.toString()));      
    }
  }

  Future<void> onSplashScreenStart(){
    return Future.delayed(const Duration(microseconds: 1));
  }

}