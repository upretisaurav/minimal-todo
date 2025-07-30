import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_todo/config/constants/size_config.dart';
import 'package:minimal_todo/config/constants/strings.dart';
import 'package:minimal_todo/config/injector/injection_container.dart' as di;
import 'package:minimal_todo/config/themes/app_theme.dart';
import 'package:minimal_todo/presentation/blocs/task/task_bloc.dart';
import 'package:minimal_todo/presentation/blocs/theme/theme_bloc.dart';
import 'package:minimal_todo/presentation/blocs/theme/theme_event.dart';
import 'package:minimal_todo/presentation/blocs/theme/theme_state.dart';
import 'package:minimal_todo/routes/app_route_conf.dart';

class MinimalTodoApp extends StatelessWidget {
  const MinimalTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = di.getIt<AppRouteConf>().router;
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create:
                  (_) =>
                      di.getIt<ThemeBloc>()..add(const LoadSavedThemeEvent()),
            ),
            BlocProvider<TaskBloc>(create: (_) => di.getIt<TaskBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appName,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                routerConfig: router,
              );
            },
          ),
        );
      },
    );
  }
}
