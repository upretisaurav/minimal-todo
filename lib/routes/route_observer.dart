import 'package:flutter/material.dart';
import 'package:minimal_todo/presentation/utils/logger.dart';

class RouteNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    Log.i(
      "Navigated from ${previousRoute?.settings.name ?? 'Start'} to ${route.settings.name ?? 'End'}",
    );
  }
}
