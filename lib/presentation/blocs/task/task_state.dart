import 'package:equatable/equatable.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';

enum TaskStatus { initial, loading, success, failure }

class TaskState extends Equatable {
  final TaskStatus status;
  final List<TaskEntity> tasks;
  final List<TaskEntity> filteredTasks;
  final TaskEntity? selectedTask;
  final String? errorMessage;

  const TaskState({
    this.status = TaskStatus.initial,
    this.tasks = const [],
    this.filteredTasks = const [],
    this.selectedTask,
    this.errorMessage,
  });

  TaskState copyWith({
    TaskStatus? status,
    List<TaskEntity>? tasks,
    List<TaskEntity>? filteredTasks,
    TaskEntity? selectedTask,
    String? errorMessage,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selectedTask: selectedTask ?? this.selectedTask,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isLoading => status == TaskStatus.loading;
  bool get isSuccess => status == TaskStatus.success;
  bool get isFailure => status == TaskStatus.failure;
  bool get hasError => errorMessage != null;
  bool get hasTasks => tasks.isNotEmpty;
  bool get hasFilteredTasks => filteredTasks.isNotEmpty;

  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((task) => task.isCompleted).length;
  int get activeTasks => tasks.where((task) => !task.isCompleted).length;

  @override
  List<Object?> get props => [
    status,
    tasks,
    filteredTasks,
    selectedTask,
    errorMessage,
  ];
}
