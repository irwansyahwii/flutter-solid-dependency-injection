import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_start.dart';
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
    
    GetIt.I.registerLazySingleton<SplashCubit>(() => SplashCubit(SplashScreenStart(), delayService: GetIt.I.get<DelayService>()));

    GetIt.I.registerLazySingleton<AppCubit>(() => AppCubit(AppStateStart()));

  }
}