import 'package:flutter/material.dart';

abstract class NavigationService {
  Future<void> navigateTo(BuildContext context, String path);
}