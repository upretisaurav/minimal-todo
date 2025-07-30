import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/core/usecases/base_usecase.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class ToggleTaskCompletionUseCase
    implements UseCase<TaskEntity, ToggleTaskCompletionParams> {
  final TaskRepository taskRepository;

  ToggleTaskCompletionUseCase(this.taskRepository);

  @override
  Future<Either<Failure, TaskEntity>> call(
    ToggleTaskCompletionParams params,
  ) async {
    final taskResult = await taskRepository.getTaskById(params.taskId);
    return taskResult.fold((failure) => Left(failure), (task) async {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      return await taskRepository.updateTask(updatedTask);
    });
  }
}

class ToggleTaskCompletionParams {
  final String taskId;

  ToggleTaskCompletionParams(this.taskId);
}
