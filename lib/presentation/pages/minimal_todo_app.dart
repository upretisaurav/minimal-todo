import 'package:flutter/material.dart';
import 'package:minimal_todo/config/constants/size_config.dart';
import 'package:minimal_todo/config/constants/strings.dart';
import 'package:minimal_todo/config/injector/injection_container.dart' as di;
import 'package:minimal_todo/routes/app_route_conf.dart';

class MinimalTodoApp extends StatelessWidget {
  const MinimalTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = di.getIt<AppRouteConf>().router;
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          routerConfig: router,
        );
      },
    );
  }
}
