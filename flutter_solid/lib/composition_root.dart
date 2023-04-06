import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_start.dart';
import 'package:flutter_solid/features/spash_screen/services/app_loading_service.dart';
import 'package:flutter_solid/features/spash_screen/services/fake_app_loading_service.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_start.dart';
import 'package:flutter_solid/shared/services/delay_service.dart';
import 'package:flutter_solid/shared/services/delay_service_future.dart';
import 'package:flutter_solid/shared/services/navigation_service.dart';
import 'package:flutter_solid/shared/services/navigation_service_go_router.dart';
import 'package:get_it/get_it.dart';

import 'features/spash_screen/splash_screen_states/splash_cubit.dart';

class CompositionRoot {
  static composeApplication(){
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<NavigationService>(NavigationServiceGoRouter());
    GetIt.I.registerSingleton<DelayService>(DelayServiceFuture());
    GetIt.I.registerSingleton<AppLoadingService>(FakeAppLoadingService());
    
    GetIt.I.registerLazySingleton<SplashCubit>(() { 
      final splashCubit = SplashCubit(SplashScreenStart(), 
        delayService: GetIt.I.get<DelayService>(),
        appLoadingService: GetIt.I.get<AppLoadingService>());

      final appCubit = GetIt.I.get<AppCubit>();

      appCubit.subscribeToSplashScreenState(splashCubit.stream);

      return splashCubit;

      });

    GetIt.I.registerLazySingleton<AppCubit>(() => AppCubit(AppStateStart()));

  }
}