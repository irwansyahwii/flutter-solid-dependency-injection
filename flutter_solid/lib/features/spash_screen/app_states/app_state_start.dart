import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_splash_screen.dart';

class AppStateStart extends AppState {


  @override
  Future<void> appClosed() {
    return Future.value();
  }

  @override
  Future<void> appLaunched() {
    return cubit!.changeState(AppStateDisplaySplashScreen(cubit: cubit!));
  }

  @override
  Future<void> loadingFinishedAndUserLoggedIn() {
    return Future.value();    
  }

  @override
  Future<void> loadingFinishedAndUserNotLoggedIn() {
    return Future.value();    
  }

  @override
  Future<void> loadingStepsThrowsError(Exception err) {
    return Future.value();    
  }
  
}