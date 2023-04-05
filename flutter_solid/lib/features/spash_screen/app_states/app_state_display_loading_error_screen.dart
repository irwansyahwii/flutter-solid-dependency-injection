import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_final.dart';

class AppStateDisplayLoadingErrorScreen extends AppState {
  final String errorMessage;


  AppStateDisplayLoadingErrorScreen({required AppCubit cubit, required this.errorMessage}){
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