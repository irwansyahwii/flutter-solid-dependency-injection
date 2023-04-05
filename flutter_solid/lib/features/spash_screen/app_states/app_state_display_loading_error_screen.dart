import 'package:flutter_solid/features/spash_screen/app_states/app_state.dart';

class AppStateDisplayLoadingErrorScreen extends AppState {
  final String _errorMessage;

  AppStateDisplayLoadingErrorScreen(this._errorMessage);

  get errorMessage {
    return _errorMessage;
  }
}