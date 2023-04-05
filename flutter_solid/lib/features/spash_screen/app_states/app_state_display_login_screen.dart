import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_final.dart';

class AppStateDisplayLoginScreen extends AppState {
  AppStateDisplayLoginScreen({required AppCubit cubit}){
    super.cubit = cubit;
  }

  @override
  Future<void> appClosed() {
    return cubit!.changeState(AppStateFinal(cubit: cubit!));    
  }

  @override
  Future<void> appLaunched() {
    return Future.value();
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