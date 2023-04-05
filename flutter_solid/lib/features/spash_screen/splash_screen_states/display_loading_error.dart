import 'package:flutter_solid/features/spash_screen/splash_screen_states/splash_screen_state.dart';

class DisplayLoadingError extends SplashScreenState{
   final String errorMessageValue;
   DisplayLoadingError({required this.errorMessageValue});

   get errorMessage{
    return errorMessageValue;
   }
}