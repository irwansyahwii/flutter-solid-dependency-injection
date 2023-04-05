import 'package:flutter_solid/shared/services/delay_service.dart';

class DelayServiceFuture extends DelayService {
  @override
  Future<void> startDelay(Duration duration) {
    return Future.delayed(duration);
  }

}