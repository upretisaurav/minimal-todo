import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_todo/presentation/blocs/filter/filter_bloc.dart';
import 'package:minimal_todo/presentation/blocs/task/task_bloc.dart';
import 'package:minimal_todo/presentation/blocs/task/task_event.dart';
import 'package:minimal_todo/presentation/widgets/task/filter_tabs.dart';
import 'package:minimal_todo/presentation/widgets/task/task_list.dart';
import 'package:minimal_todo/routes/app_route_path.dart';
import '../../../../config/constants/colors.dart';
import '../../../../config/constants/dimensions.dart';
import '../../../../config/injector/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (_) => getIt<TaskBloc>()..add(const LoadTasksEvent()),
        ),
        BlocProvider<FilterBloc>(create: (_) => getIt<FilterBloc>()),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.paddingM),

                  Text(
                    'My Tasks',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Text(
                    'Stay organized, get things done',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurface.withAlpha(128),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),

                  const FilterTabs(),
                ],
              ),
            ),

            const Expanded(child: TaskList()),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(context),
        backgroundColor: context.colors.primary,
        child: Icon(Icons.add, color: context.colors.onPrimary, size: 28),
      ),
    );
  }

  void _navigateToAddTask(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    context.push(AppRoute.addEditTask.path).then((_) {
      taskBloc.add(const RefreshTasksEvent());
    });
  }
}
