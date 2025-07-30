import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
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
    on<RefreshTasksEvent>(_onRefreshTasks);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(status: TaskStatus.loading));

    final result = await getTasksUseCase(GetTasksParams(filter: event.filter));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: TaskStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (tasks) {
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: tasks,
            filteredTasks: tasks,
            errorMessage: null,
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
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: updatedTasks,
            errorMessage: null,
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
            List<TaskEntity>.from(state.tasks)
              ..removeWhere((task) => task.id == updatedTask.id)
              ..add(updatedTask);
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: updatedTasks,
            errorMessage: null,
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
        final updatedTasks = List<TaskEntity>.from(state.tasks)
          ..removeWhere((task) => task.id == event.taskId);
        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: updatedTasks,
            errorMessage: null,
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
        final updatedTasks =
            state.tasks
                .map((task) => task.id == updatedTask.id ? updatedTask : task)
                .toList();

        emit(
          state.copyWith(
            status: TaskStatus.success,
            tasks: updatedTasks,
            filteredTasks: updatedTasks,
            errorMessage: null,
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
        emit(
          state.copyWith(
            status: TaskStatus.success,
            selectedTask: task,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshTasks(
    RefreshTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    add(const LoadTasksEvent());
  }
}
