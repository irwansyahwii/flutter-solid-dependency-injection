import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_loading_error_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_login_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_main_screen.dart';

import 'app_cubit.dart';

class AppStateDisplaySplashScreen extends AppState 
{
  AppStateDisplaySplashScreen({required AppCubit cubit}){
    super.cubit = cubit;
  }

  @override
  Future<void> appClosed() {
    return Future.value();
  }

  @override
  Future<void> appLaunched() {
    return Future.value();    
  }

  @override
  Future<void> loadingFinishedAndUserLoggedIn() {
    return cubit!.changeState(AppStateDisplayMainScreen(cubit: cubit!));
  }

  @override
  Future<void> loadingFinishedAndUserNotLoggedIn() {
    return cubit!.changeState(AppStateDisplayLoginScreen(cubit: cubit!));
  }

  @override
  Future<void> loadingStepsThrowsError(Exception err) {
    return cubit!.changeState(AppStateDisplayLoadingErrorScreen(cubit: cubit!, errorMessage: err.toString()));    
  }
  
}