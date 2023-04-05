import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_loading_error_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_login_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_main_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_splash_screen.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit(super.initialState);  

  appLaunched(){
    Future.delayed(const Duration(microseconds: 1));
    emit(AppStateDisplaySplashScreen());
  }

  void loadingFinishedAndUserLoggedIn() {
    emit(AppStateDisplayMainScreen());
  }

  void loadingFinishedAndUserNotLoggedIn() {
    emit(AppStateDisplayLoginScreen());
  }

  void loadingStepsThrowsError(String errorMessage) {    
    emit(AppStateDisplayLoadingErrorScreen(errorMessage));
  }

}