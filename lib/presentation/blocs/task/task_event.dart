import 'package:equatable/equatable.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {
  final TaskFilterEntity? filter;

  const LoadTasksEvent({this.filter});

  @override
  List<Object?> get props => [filter];
}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  const AddTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class ToggleTaskCompletionEvent extends TaskEvent {
  final String taskId;

  const ToggleTaskCompletionEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class GetTaskByIdEvent extends TaskEvent {
  final String taskId;

  const GetTaskByIdEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class RefreshTasksEvent extends TaskEvent {
  const RefreshTasksEvent();
}

class ApplyFilterEvent extends TaskEvent {
  final TaskFilter filter;

  const ApplyFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
