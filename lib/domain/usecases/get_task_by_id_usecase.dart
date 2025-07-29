import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/core/usecases/base_usecase.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class GetTaskByIdUseCase implements UseCase<TaskEntity, GetTaskByIdParams> {
  final TaskRepository repository;

  GetTaskByIdUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(GetTaskByIdParams params) {
    return repository.getTaskById(params.taskId);
  }
}

class GetTaskByIdParams {
  final String taskId;

  GetTaskByIdParams({required this.taskId});
}
