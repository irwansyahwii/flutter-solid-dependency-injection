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
import 'package:flutter_solid/shared/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        final navigationService = GetIt.I.get<NavigationService>();
        switch(state.runtimeType){          
          case AppStateDisplayMainScreen:
            navigationService.navigateTo(context, '/mainscreen');
            break;
          case AppStateDisplayLoginScreen:
            navigationService.navigateTo(context,'/loginscreen');
            break;
          case AppStateDisplayLoadingErrorScreen:
            navigationService.navigateTo(context,'/loadingerrorscreen');
            break;
        }
      },
      child: BlocProvider(
      create: (context) => GetIt.I.get<SplashCubit>()..startLoading(),
      child: BlocListener<SplashCubit, SplashScreenState>(
        listener: (context, state) {
          switch(state.runtimeType){
            case SplashScreenStart:
              context.read<SplashCubit>().startLoading();
              break;
            case DisplayLoadingFinished:
              context.read<SplashCubit>().startDelay();
              break;
            case DisplayLoadingError:
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
        }, 

      child: BlocBuilder<SplashCubit, SplashScreenState>(     

        builder:  (context, state) {
          
          String statusText = "";

          switch(state.runtimeType){
            case SplashScreenLoading:
              statusText = "Loading..";
              break;            
            case DisplayLoadingFinished:
              statusText = "Loading finished!";
              break;
            case DisplayLoadingError:
              statusText = (state as DisplayLoadingError).errorMessageValue;
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
      )));
    
  }

}