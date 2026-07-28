import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';
import 'package:minimal_todo/domain/usecases/add_task_usecase.dart';
import 'package:minimal_todo/domain/usecases/delete_task_usecase.dart';
import 'package:minimal_todo/domain/usecases/get_task_by_id_usecase.dart';
import 'package:minimal_todo/domain/usecases/get_tasks_usecase.dart';
import 'package:minimal_todo/domain/usecases/toggle_task_completion_usecase.dart';
import 'package:minimal_todo/domain/usecases/update_task_usecase.dart';
import 'package:minimal_todo/presentation/blocs/task/task_event.dart';
import 'package:minimal_todo/presentation/blocs/task/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase addTaskUseCase;
  final GetTasksUseCase getTasksUseCase;
  final GetTaskByIdUseCase getTaskByIdUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final ToggleTaskCompletionUseCase toggleTaskCompletionUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskFilter _currentFilter = TaskFilter.all;

  TaskBloc({
    required this.addTaskUseCase,
    required this.getTasksUseCase,
    required this.getTaskByIdUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
    required this.toggleTaskCompletionUseCase,
  }) : super(const TaskState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<ToggleTaskCompletionEvent>(_onToggleTaskCompletion);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<GetTaskByIdEvent>(_onGetTaskById);
    on<ApplyFilterEvent>(_onApplyFilter);
    on<RefreshTasksEvent>(_onRefreshTasks);
  }

  // Getter for current filter (for UI to access)
  TaskFilter get currentFilter => _currentFilter;

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    if (event.filter != null) {
      _currentFilter = event.filter!.filter;
    }

    final result = await getTasksUseCase(GetTasksParams(filter: event.filter));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (tasks) {
        print('Applying filter: $_currentFilter on tasks: $tasks');
        final filteredTasks = _applyFilter(tasks, _currentFilter);
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: tasks,
            filteredTasks: filteredTasks,
          ),
        );
      },
    );
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: TaskStatus.loading));

    final result = await addTaskUseCase(AddTaskParams(event.task));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (task) {
        final updatedTasks = List<TaskEntity>.from(state.tasks)..add(task);
        final filteredTasks = _applyFilter(updatedTasks, _currentFilter);
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: filteredTasks,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    final result = await updateTaskUseCase(UpdateTaskParams(event.task));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (updatedTask) {
        final updatedTasks =
            state.tasks.map((task) {
              return task.id == updatedTask.id ? updatedTask : task;
            }).toList();

        final filteredTasks = _applyFilter(updatedTasks, _currentFilter);
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: filteredTasks,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    final result = await deleteTaskUseCase(
      DeleteTaskParams(taskId: event.taskId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (success) {
        final updatedTasks =
            state.tasks.where((task) => task.id != event.taskId).toList();
        final filteredTasks = _applyFilter(updatedTasks, _currentFilter);
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: filteredTasks,
          ),
        );
      },
    );
  }

  Future<void> _onToggleTaskCompletion(
    ToggleTaskCompletionEvent event,
    Emitter<TaskState> emit,
  ) async {
    final result = await toggleTaskCompletionUseCase(
      ToggleTaskCompletionParams(event.taskId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (updatedTask) {
        print(
          'Task toggled: ${updatedTask.id} -> isCompleted: ${updatedTask.isCompleted}',
        );

        final updatedTasks =
            state.tasks.map((task) {
              return task.id == updatedTask.id ? updatedTask : task;
            }).toList();

        print('Applying filter: $_currentFilter on tasks: $updatedTasks');
        final filteredTasks = _applyFilter(updatedTasks, _currentFilter);
        print('Filtered tasks: $filteredTasks');

        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: filteredTasks,
          ),
        );
      },
    );
  }

  Future<void> _onGetTaskById(
    GetTaskByIdEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    final result = await getTaskByIdUseCase(
      GetTaskByIdParams(taskId: event.taskId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (task) {
        emit(state.copyWith(status: TaskStatus.success, selectedTask: task));
      },
    );
  }

  Future<void> _onRefreshTasks(
    RefreshTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    add(LoadTasksEvent(filter: _createCurrentFilterEntity()));
  }

  void _onApplyFilter(ApplyFilterEvent event, Emitter<TaskState> emit) {
    print('Applying current filter: ${event.filter}');

    print('Applying filter: ${event.filter} on tasks: ${state.tasks}');
    final filteredTasks = _applyFilter(state.tasks, event.filter);
    print('Filtered tasks: $filteredTasks');

    emit(
      state.copyWith(filteredTasks: filteredTasks, currentFilter: event.filter),
    );
  }

  List<TaskEntity> _applyFilter(List<TaskEntity> tasks, TaskFilter filter) {
    switch (filter) {
      case TaskFilter.all:
        return List.from(tasks);
      case TaskFilter.active:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
    }
  }

  TaskFilterEntity? _createCurrentFilterEntity() {
    return TaskFilterEntity(filter: _currentFilter);
  }
}
