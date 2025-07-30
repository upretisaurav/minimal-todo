import 'package:flutter/material.dart';
import '../../../config/constants/colors.dart';
import '../../../config/constants/dimensions.dart';
import '../../../domain/entities/task_entity.dart';

class PriorityBadge extends StatelessWidget {
  final TaskPriority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: context.priorityBgColor(priority.displayName),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Text(
        priority.displayName.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _getPriorityColor(context, priority),
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }

  Color _getPriorityColor(BuildContext context, TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return context.priorityHighColor;
      case TaskPriority.medium:
        return context.priorityMediumColor;
      case TaskPriority.low:
        return context.priorityLowColor;
    }
  }
}
