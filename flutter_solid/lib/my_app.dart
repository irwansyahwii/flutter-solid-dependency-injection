import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/shared/routing/router_config.dart';
import 'package:get_it/get_it.dart';
import 'features/spash_screen/app_states/app_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<AppCubit>(),      
      child:MaterialApp.router(routerConfig: routerConfig));
    // return MaterialApp.router(routerConfig: routerConfig,);
  }
}