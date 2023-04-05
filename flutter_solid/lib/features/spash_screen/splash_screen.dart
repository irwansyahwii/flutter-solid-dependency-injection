import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_loading_error_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_login_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_main_screen.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_error.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_finished.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_cubit.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_loading.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_start.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        switch(state.runtimeType){
          case AppStateDisplayMainScreen:
            context.go('/mainscreen');
            break;
          case AppStateDisplayLoginScreen:
            context.go('/loginscreen');
            break;
          case AppStateDisplayLoadingErrorScreen:
            context.go('/loadingerrorscreen');
            break;
        }
      },
      child: BlocProvider(
      create: (context) => SplashCubit(SplashScreenStart()),

      child: BlocBuilder<SplashCubit, SplashScreenState>(
        builder:  (context, state) {
          
          String statusText = "";

          switch(state.runtimeType){
            case SplashScreenStart:
              context.read<SplashCubit>().startLoading();
              break;
            case SplashScreenLoading:
              statusText = "Loading..";
              break;            
            case DisplayLoadingFinished:
              statusText = "Loading finished!";
              context.read<SplashCubit>().startDelay();
              break;
            case DisplayLoadingError:
              statusText = (state as DisplayLoadingError).errorMessageValue;
              context.read<SplashCubit>().startZeroDelay();
              break;
            case SplashScreenFinalState:
              final currentState = (state as SplashScreenFinalState);
              if(currentState.isErrorHappened){                
                context.read<AppCubit>().loadingStepsThrowsError(currentState.errorMessage);
              }else {
                if(currentState.isUserLoggedIn){
                  context.read<AppCubit>().loadingFinishedAndUserLoggedIn();
                }else{
                  context.read<AppCubit>().loadingFinishedAndUserNotLoggedIn();
                }
              }              
              break;
          }

          return Scaffold(
            backgroundColor: Colors.redAccent,
            body: Center(
              child: Text(statusText),
            ),
          );

        },
      ),
      ));
    
  }

}