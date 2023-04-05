import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_cubit.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';
import 'package:flutter_solid/features/spash_screen/app_states/app_state_display_loading_error_screen.dart';

class LoadingErrorScreen extends StatelessWidget {
  const LoadingErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        
      },
      builder:(context, state) {
        final errorMessage = (state as AppStateDisplayLoadingErrorScreen).errorMessage;

        return Scaffold(
           body: Center(
              child: Text(errorMessage),
          ),
        );

      },);

  } 
}