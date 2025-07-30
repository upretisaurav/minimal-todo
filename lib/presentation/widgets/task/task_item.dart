import 'package:flutter/material.dart';
import 'package:minimal_todo/core/utils/app_date_utils.dart';
import '../../../config/constants/colors.dart';
import '../../../config/constants/dimensions.dart';
import '../../../domain/entities/task_entity.dart';
import 'priority_badge.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onToggleComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      onLongPress: onDelete,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: context.taskCardBg,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(color: context.taskCardBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onToggleComplete,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color:
                          task.isCompleted
                              ? context.colors.onSurface
                              : Colors.transparent,
                      border: Border.all(
                        color:
                            task.isCompleted
                                ? context.colors.onSurface
                                : context.colors.onSurface.withAlpha(128),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child:
                        task.isCompleted
                            ? Icon(
                              Icons.check,
                              size: 16,
                              color: context.colors.surface,
                            )
                            : null,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),

                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: context.colors.onSurface,
                      fontWeight: FontWeight.w600,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),

                PriorityBadge(priority: task.priority),
              ],
            ),

            if (task.hasDescription) ...[
              const SizedBox(height: AppDimensions.paddingS),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  task.description!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurface.withAlpha(128),
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],

            const SizedBox(height: AppDimensions.paddingM),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  if (task.hasDueDate) ...[
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color:
                          task.isOverdue
                              ? AppColors.error
                              : context.colors.onSurface.withAlpha(128),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppDateUtils.formatDate(task.dueDate!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            task.isOverdue
                                ? AppColors.error
                                : context.colors.onSurface.withAlpha(128),
                        fontWeight: task.isOverdue ? FontWeight.w600 : null,
                      ),
                    ),
                    const Spacer(),
                  ] else
                    const Spacer(),

                  Text(
                    'Created ${AppDateUtils.formatDate(task.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurface.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
