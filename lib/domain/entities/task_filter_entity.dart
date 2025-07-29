enum TaskFilter { all, active, completed }

class TaskFilterEntity {
  final TaskFilter filter;
  final DateTime? startDate;
  final DateTime? endDate;

  const TaskFilterEntity({required this.filter, this.startDate, this.endDate});

  TaskFilterEntity copyWith({
    TaskFilter? filter,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TaskFilterEntity(
      filter: filter ?? this.filter,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
