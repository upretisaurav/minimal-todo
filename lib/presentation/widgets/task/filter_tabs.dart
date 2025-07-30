import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/colors.dart';
import '../../../config/constants/dimensions.dart';
import '../../../config/constants/strings.dart';
import '../../../domain/entities/task_filter_entity.dart';
import '../../blocs/filter/filter_bloc.dart';
import '../../blocs/filter/filter_event.dart';
import '../../blocs/filter/filter_state.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          child: Row(
            children: [
              _FilterTab(
                title: AppStrings.filterAll,
                isSelected: filterState.currentFilter == TaskFilter.all,
                onTap: () => _onFilterChanged(context, TaskFilter.all),
              ),
              _FilterTab(
                title: AppStrings.filterActive,
                isSelected: filterState.currentFilter == TaskFilter.active,
                onTap: () => _onFilterChanged(context, TaskFilter.active),
              ),
              _FilterTab(
                title: AppStrings.filterCompleted,
                isSelected: filterState.currentFilter == TaskFilter.completed,
                onTap: () => _onFilterChanged(context, TaskFilter.completed),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onFilterChanged(BuildContext context, TaskFilter filter) {
    context.read<FilterBloc>().add(ChangeFilterEvent(filter));
    final filterEntity = context.read<FilterBloc>().state.toEntity();
    context.read<TaskBloc>().add(LoadTasksEvent(filter: filterEntity));
  }
}

class _FilterTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingS,
          ),
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color:
                  isSelected
                      ? context.colors.onPrimary
                      : context.colors.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
