import 'package:flutter_solid/features/spash_screen/services/app_loading_service.dart';

class FakeAppLoadingService extends AppLoadingService {
  @override
  Future<void> run() async {
    await Future.delayed(const Duration(seconds: 3));

    isUserLoggedIn = false;

    // throw Exception("adadsa");
  }
  
}