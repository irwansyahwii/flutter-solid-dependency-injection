import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_login_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_main_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_splash_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_start.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class AppCubit extends Cubit<AppState>{

  AppCubit(super.initialState){
    state.cubit = this;
    state.appLaunched();
  }


  subscribeToSplashScreenState(Stream<SplashScreenState> splashScreenState){
    splashScreenState.listen((splashState) {
      if(splashState.runtimeType == SplashScreenFinalState){          
        final splashFinalState = (splashState as SplashScreenFinalState);
        if(splashFinalState.isUserLoggedIn){
          state.loadingFinishedAndUserLoggedIn();
        }else if(splashFinalState.isErrorHappened){
          state.loadingStepsThrowsError(Exception(splashFinalState.errorMessage));
        }else {
          state.loadingFinishedAndUserNotLoggedIn();
        }
      }
    });
  }


  Future<void> changeState(AppState appState) {
    print('Changing state to newState: $appState');
    emit(appState);    

    switch(appState.runtimeType){
      case AppStateDisplaySplashScreen:
        return onDisplaySplashScreen();  
      case AppStateDisplayMainScreen:
        return onDisplayMainScreen();
      case AppStateDisplayLoginScreen:
        return onDisplayLoginScreen();
      case AppStateStart:
        return onAppStateStart();
      default:
        return Future.value();
    }

    
  }

  Future<void> onAppStateStart(){
    return state.appLaunched();
  }

  Future<void> onDisplaySplashScreen(){    
    return Future.value();
  }

  Future<void> onDisplayMainScreen(){
    return Future.value();
  }

  Future<void> onDisplayLoginScreen(){
    return Future.value();
  }

}