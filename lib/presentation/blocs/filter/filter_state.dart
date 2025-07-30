import 'package:equatable/equatable.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';

class FilterState extends Equatable {
  final TaskFilter currentFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool hasActiveFilters;

  const FilterState({
    this.currentFilter = TaskFilter.all,
    this.startDate,
    this.endDate,
    this.hasActiveFilters = false,
  });

  FilterState copyWith({
    TaskFilter? currentFilter,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    bool? hasActiveFilters,
  }) {
    return FilterState(
      currentFilter: currentFilter ?? this.currentFilter,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      hasActiveFilters: hasActiveFilters ?? this.hasActiveFilters,
    );
  }

  TaskFilterEntity toEntity() {
    return TaskFilterEntity(
      filter: currentFilter,
      startDate: startDate,
      endDate: endDate,
    );
  }

  bool get hasDateRange => startDate != null || endDate != null;

  @override
  List<Object?> get props => [
    currentFilter,
    startDate,
    endDate,
    hasActiveFilters,
  ];
}
