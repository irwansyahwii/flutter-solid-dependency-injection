import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_loading_error_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_login_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_main_screen.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_start.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_error.dart';
import 'package:flutter_solid/features/spash_screen/splash_screen_states/display_loading_finished.dart';
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

class FakeDelayService extends DelayService {
  @override
  Future<void> startDelay(Duration duration) {
    return Future.value();
  }

}

class FakeSplashCubit extends SplashCubit {
  FakeSplashCubit(super.initialState, {required super.delayService});

  @override
  Future<void> startLoading() async{    
    await delayService.startDelay(const Duration(microseconds: 1));
    emit(SplashScreenLoading());
  }

  loadingFinished()async {
    await delayService.startDelay(const Duration(microseconds: 1));
    emit(DisplayLoadingFinished(isUserLoggedIn: true));
  }

  loadingFinishedAndUserLoggedIn()async{

    await delayService.startDelay(const Duration(microseconds: 1));
    emit(DisplayLoadingFinished(isUserLoggedIn: true));

    await delayService.startDelay(const Duration(microseconds: 1));
    delayFinished();

  }
  loadingFinishedAndUserNotLoggedIn()async{
    await delayService.startDelay(const Duration(microseconds: 1));
    emit(DisplayLoadingFinished(isUserLoggedIn: false));

    await delayService.startDelay(const Duration(microseconds: 1));
    delayFinished();
  }

  @override
  Future<void> startDelay() async {    
    await delayService.startDelay(const Duration(seconds: 2));
  }


}

class FakeNavigationService extends NavigationService {
  String currentPath = '';
  @override
  Future<void> navigateTo(BuildContext context, String path) {
    currentPath = path;

    return Future.value();
  }

}
void main() {
  testWidgets('SplashScreen display loading message when the state is SplashScreenLoading', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<NavigationService>(FakeNavigationService());
    GetIt.I.registerSingleton<DelayService>(FakeDelayService());

    final appCubit = AppCubit(AppStateStart());
    GetIt.I.registerSingleton<AppCubit>(appCubit);
    
    GetIt.I.registerLazySingleton<SplashCubit>(() => FakeSplashCubit(SplashScreenStart(), delayService: GetIt.I.get<DelayService>()));

    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 1));

    final splashCubit = GetIt.I.get<SplashCubit>();
    await tester.pump(const Duration(seconds: 1));

    expect(splashCubit.state.runtimeType, SplashScreenLoading);

    expect(find.text('Loading..'), findsOneWidget);

  });



  testWidgets('SplashScreen display loading finished message when the state is DisplayLoadingFinished', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<NavigationService>(FakeNavigationService());
    GetIt.I.registerSingleton<DelayService>(FakeDelayService());

    final appCubit = AppCubit(AppStateStart());
    GetIt.I.registerSingleton<AppCubit>(appCubit);
    
    GetIt.I.registerLazySingleton<SplashCubit>(() => FakeSplashCubit(SplashScreenStart(), delayService: GetIt.I.get<DelayService>()));

    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 1));

    final splashCubit = GetIt.I.get<SplashCubit>();
    await tester.pump(const Duration(seconds: 1));

    final fakeSplashCubit = (splashCubit as FakeSplashCubit);

    fakeSplashCubit.loadingFinished();
    await tester.pump(const Duration(seconds: 2));

    expect(splashCubit.state.runtimeType, DisplayLoadingFinished);

    expect(find.text('Loading finished!'), findsOneWidget);

  });  

  testWidgets('App display login screen after loading finished and user is not logged in', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<NavigationService>(FakeNavigationService());
    GetIt.I.registerSingleton<DelayService>(FakeDelayService());

    final appCubit = AppCubit(AppStateStart());
    GetIt.I.registerSingleton<AppCubit>(appCubit);
    
    GetIt.I.registerLazySingleton<SplashCubit>(() => FakeSplashCubit(SplashScreenStart(), delayService: GetIt.I.get<DelayService>()));

    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 1));

    final splashCubit = GetIt.I.get<SplashCubit>();
    await tester.pump(const Duration(seconds: 1));

    final fakeSplashCubit = (splashCubit as FakeSplashCubit);

    fakeSplashCubit.loadingFinishedAndUserNotLoggedIn();
    await tester.pump(const Duration(seconds: 2));

    expect(appCubit.state.runtimeType, AppStateDisplayLoginScreen);

    final fakeNavigationService = (GetIt.I.get<NavigationService>() as FakeNavigationService);

    expect(fakeNavigationService.currentPath, '/loginscreen');

  });  
  testWidgets('App display main screen after loading finished and user is logged in', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<NavigationService>(NavigationServiceGoRouter());
    GetIt.I.registerSingleton<DelayService>(FakeDelayService());

    final appCubit = AppCubit(AppStateStart());
    GetIt.I.registerSingleton<AppCubit>(appCubit);
    
    GetIt.I.registerLazySingleton<SplashCubit>(() => FakeSplashCubit(SplashScreenStart(), delayService: GetIt.I.get<DelayService>()));

    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 1));

    final splashCubit = GetIt.I.get<SplashCubit>();
    await tester.pump(const Duration(seconds: 1));

    final fakeSplashCubit = (splashCubit as FakeSplashCubit);

    fakeSplashCubit.loadingFinishedAndUserLoggedIn();
    await tester.pump(const Duration(seconds: 2));

    expect(appCubit.state.runtimeType, AppStateDisplayMainScreen);


    await tester.pumpAndSettle();
    expect(find.text('MainScreen'), findsOneWidget);

  });  

  testWidgets('App display loading error screen after loading throws an error', (WidgetTester tester) async {
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<NavigationService>(NavigationServiceGoRouter());
    GetIt.I.registerSingleton<DelayService>(FakeDelayService());

    final appCubit = AppCubit(AppStateStart());
    GetIt.I.registerSingleton<AppCubit>(appCubit);
    
    GetIt.I.registerLazySingleton<SplashCubit>(() => FakeSplashCubit(SplashScreenStart(), delayService: GetIt.I.get<DelayService>()));

    await tester.pumpWidget(const MyApp());

    await tester.pump(const Duration(seconds: 1));

    final splashCubit = GetIt.I.get<SplashCubit>();
    await tester.pump(const Duration(seconds: 1));

    final fakeSplashCubit = (splashCubit as FakeSplashCubit);
    

    await fakeSplashCubit.loadingStepsThrowsError(Exception("error nih"));
    await tester.pumpAndSettle();
    
    fakeSplashCubit.delayFinished();
    await tester.pump(const Duration(seconds: 2));
    

    expect(appCubit.state.runtimeType, AppStateDisplayMainScreen);


    await tester.pumpAndSettle();
    expect(find.text('MainScreen'), findsOneWidget);
  });    
}