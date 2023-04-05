import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';

import 'app_state.dart';

class AppStateFinal extends AppState {
  AppStateFinal({required AppCubit cubit}){
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