import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/core/usecases/base_usecase.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class UpdateTaskUsecase implements UseCase<TaskEntity, UpdateTaskParams> {
  final TaskRepository repository;

  UpdateTaskUsecase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(UpdateTaskParams params) {
    return repository.updateTask(params.task);
  }
}

class UpdateTaskParams {
  final TaskEntity task;

  UpdateTaskParams(this.task);
}
