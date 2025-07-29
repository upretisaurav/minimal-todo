import 'package:minimal_todo/domain/entities/task_filter_entity.dart';

class TaskFilterModel {
  final String filter;
  final DateTime? startDate;
  final DateTime? endDate;

  TaskFilterModel({required this.filter, this.startDate, this.endDate});

  factory TaskFilterModel.fromEntity(TaskFilterEntity entity) {
    return TaskFilterModel(
      filter: _filterToString(entity.filter),
      startDate: entity.startDate,
      endDate: entity.endDate,
    );
  }

  TaskFilterEntity toEntity() {
    return TaskFilterEntity(
      filter: _stringToFilter(filter),
      startDate: startDate,
      endDate: endDate,
    );
  }

  static String _filterToString(TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        return 'all';
      case TaskFilter.active:
        return 'active';
      case TaskFilter.completed:
        return 'completed';
    }
  }

  static TaskFilter _stringToFilter(String filter) {
    switch (filter) {
      case 'all':
        return TaskFilter.all;
      case 'active':
        return TaskFilter.active;
      case 'completed':
        return TaskFilter.completed;
      default:
        return TaskFilter.all;
    }
  }
}
