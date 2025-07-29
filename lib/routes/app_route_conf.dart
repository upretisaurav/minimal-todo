import 'package:go_router/go_router.dart';

import 'package:minimal_todo/routes/app_route_path.dart';
import 'package:minimal_todo/routes/route_observer.dart';
import 'package:minimal_todo/routes/routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    observers: [RouteNavigatorObserver()],
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
