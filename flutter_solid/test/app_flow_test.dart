import 'package:flutter/widgets.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_login_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_main_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_splash_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_start.dart';
import 'package:flutter_solid/features/spash_screen/services/app_loading_service.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_cubit.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_final_state.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_loading.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_start.dart';
import 'package:flutter_solid/my_app.dart';
import 'package:flutter_solid/shared/services/delay_service.dart';
import 'package:flutter_solid/shared/services/navigation_service.dart';
import 'package:flutter_solid/shared/services/navigation_service_go_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class FakeDelayServiceDoNothing extends DelayService {
  @override
  Future<void> startDelay(Duration duration) {
    return Future.delayed(duration);
  }
  
}

class FakeLoadingServiceJustDelay extends AppLoadingService {
  final WidgetTester tester;
  FakeLoadingServiceJustDelay(this.tester);
  @override
  Future<void> run() {
    // return tester.runAsync(() => Future.delayed(const Duration(seconds: 1)));
    return Future.delayed(const Duration(seconds: 3));
  }

}


void main() {
  
  testWidgets('app DisplaySplashScreen after launched', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    await GetIt.I.reset(dispose: true);

    await tester.pumpAndSettle();

    GetIt.I.registerSingleton<NavigationService>(NavigationServiceGoRouter());
    GetIt.I.registerSingleton<DelayService>(FakeDelayServiceDoNothing());
    GetIt.I.registerSingleton<AppLoadingService>(FakeLoadingServiceJustDelay(tester));

    final appCubit = AppCubit(AppStateStart());
    final splashCubit = SplashCubit(SplashScreenStart(), 
      delayService: GetIt.I.get<DelayService>(), 
      appLoadingService: GetIt.I.get<AppLoadingService>());

    appCubit.subscribeToSplashScreenState(splashCubit.stream);

    GetIt.I.registerSingleton<SplashCubit>(splashCubit);
    GetIt.I.registerSingleton<AppCubit>(appCubit);
    
    await tester.pumpWidget(const MyApp());
    

    expect(appCubit.state.runtimeType, AppStateDisplaySplashScreen);
    expect(splashCubit.state.runtimeType, SplashScreenLoading);
    
    expect(find.byKey(const Key('splash-screen')), findsOneWidget);
    expect(find.text("Loading..."), findsOneWidget);
    await tester.pump(const Duration(seconds: 6));

  });
  

  testWidgets('app DisplayMainScreen when the user logged in and loading finished', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    await GetIt.I.reset(dispose: true);

    await tester.pumpAndSettle();

    final fakeLoadingServiceUserLoggedIn = FakeLoadingServiceJustDelay(tester);
    fakeLoadingServiceUserLoggedIn.isUserLoggedIn = true;

    GetIt.I.registerSingleton<NavigationService>(NavigationServiceGoRouter());
    GetIt.I.registerSingleton<DelayService>(FakeDelayServiceDoNothing());
    GetIt.I.registerSingleton<AppLoadingService>(fakeLoadingServiceUserLoggedIn);


    GetIt.I.registerLazySingleton(() => SplashCubit(SplashScreenStart(), 
      delayService: GetIt.I.get<DelayService>(), 
      appLoadingService: GetIt.I.get<AppLoadingService>()));
    GetIt.I.registerLazySingleton(() => AppCubit(AppStateStart()));

    final appCubit = GetIt.I.get<AppCubit>();    
    final splashCubit = GetIt.I.get<SplashCubit>();    
    appCubit.subscribeToSplashScreenState(splashCubit.stream);

    
    const myApp = MyApp();
    await tester.pumpWidget(myApp, const Duration(seconds: 6));
    await tester.pumpAndSettle(const Duration(seconds: 6));    

    expect(appCubit.state.runtimeType, AppStateDisplayMainScreen);
    expect(splashCubit.state.runtimeType, SplashScreenFinalState);
        
    await tester.pumpFrames(myApp, const Duration(seconds: 10));    
    
    // expect(find.byKey(const Key('main-screen')), findsOneWidget);

  });  

  testWidgets('app DisplayLoginScreen when the user is not logged in and loading finished', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    await GetIt.I.reset(dispose: true);

    await tester.pumpAndSettle();

    final fakeLoadingServiceUserLoggedIn = FakeLoadingServiceJustDelay(tester);
    fakeLoadingServiceUserLoggedIn.isUserLoggedIn = false;

    GetIt.I.registerSingleton<NavigationService>(NavigationServiceGoRouter());
    GetIt.I.registerSingleton<DelayService>(FakeDelayServiceDoNothing());
    GetIt.I.registerSingleton<AppLoadingService>(fakeLoadingServiceUserLoggedIn);


    GetIt.I.registerLazySingleton(() => SplashCubit(SplashScreenStart(), 
      delayService: GetIt.I.get<DelayService>(), 
      appLoadingService: GetIt.I.get<AppLoadingService>()));
    GetIt.I.registerLazySingleton(() => AppCubit(AppStateStart()));

    final appCubit = GetIt.I.get<AppCubit>();    
    final splashCubit = GetIt.I.get<SplashCubit>();    
    appCubit.subscribeToSplashScreenState(splashCubit.stream);

    
    const myApp = MyApp();
    await tester.pumpWidget(myApp, const Duration(seconds: 6));
    await tester.pumpAndSettle(const Duration(seconds: 6));    

    expect(appCubit.state.runtimeType, AppStateDisplayLoginScreen);
    expect(splashCubit.state.runtimeType, SplashScreenFinalState);
        
    await tester.pumpFrames(myApp, const Duration(seconds: 10));    
    
    // expect(find.byKey(const Key('main-screen')), findsOneWidget);

  });    
}