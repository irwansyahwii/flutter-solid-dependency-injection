abstract class AppLoadingService {
  bool isUserLoggedIn = false;
  bool isErrorHappened = false;
  String errorMessage = "";
  
  Future<void> run();
}