
import 'package:flutter/widgets.dart';
import 'package:flutter_solid/shared/services/navigation_service.dart';
import 'package:go_router/go_router.dart';

class NavigationServiceGoRouter extends NavigationService {
  @override
  Future<void> navigateTo(BuildContext context, String path) async{
    print('navigating to $path');
    // context.go(path);
    await GoRouter.of(context).push(path);
    return Future.value();
  }

}