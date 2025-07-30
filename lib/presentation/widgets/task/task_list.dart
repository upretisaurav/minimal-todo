import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/presentation/blocs/task/task_event.dart';
import 'package:minimal_todo/presentation/widgets/task/task_item.dart';
import 'package:minimal_todo/routes/app_route_path.dart';
import '../../../config/constants/dimensions.dart';
import '../../../config/constants/strings.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_state.dart';
import '../common/loading_widget.dart';
import '../common/error_widget.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const LoadingWidget();
        }

        if (state.isFailure) {
          return CustomErrorWidget(
            message: state.errorMessage ?? AppStrings.unexpectedError,
            onRetry: () {
              context.read<TaskBloc>().add(const RefreshTasksEvent());
            },
          );
        }

        if (!state.hasFilteredTasks) {
          return const _EmptyTasksWidget();
        }

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            itemCount: state.filteredTasks.length,
            separatorBuilder:
                (context, index) =>
                    const SizedBox(height: AppDimensions.paddingM),
            itemBuilder: (context, index) {
              final task = state.filteredTasks[index];
              return TaskItem(
                task: task,
                onToggleComplete: () {
                  context.read<TaskBloc>().add(
                    ToggleTaskCompletionEvent(task.id),
                  );
                },
                onEdit: () => _navigateToEditTask(context, task),
                onDelete: () => _showDeleteDialog(context, task.id),
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToEditTask(BuildContext context, TaskEntity task) {
    final taskBloc = context.read<TaskBloc>();
    context.push(AppRoute.addEditTask.path, extra: task).then((_) {
      taskBloc.add(const RefreshTasksEvent());
    });
  }

  void _showDeleteDialog(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text(AppStrings.deleteTask),
            content: const Text(AppStrings.deleteTaskConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  context.read<TaskBloc>().add(DeleteTaskEvent(taskId));
                },
                child: const Text(AppStrings.delete),
              ),
            ],
          ),
    );
  }
}

class _EmptyTasksWidget extends StatelessWidget {
  const _EmptyTasksWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Text(
            AppStrings.noTasksYet,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            AppStrings.addFirstTask,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ],
      ),
    );
  }
}
