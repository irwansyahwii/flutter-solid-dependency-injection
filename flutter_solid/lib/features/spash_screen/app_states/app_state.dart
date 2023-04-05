import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';

abstract class AppState {  
  AppCubit? cubit;
  
  Future<void> appLaunched();
  Future<void> loadingFinishedAndUserLoggedIn();
  Future<void> loadingFinishedAndUserNotLoggedIn();
  Future<void> loadingStepsThrowsError(Exception err);
  Future<void> appClosed();
}