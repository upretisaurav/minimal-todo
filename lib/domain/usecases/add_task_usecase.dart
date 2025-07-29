import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/core/usecases/base_usecase.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class AddTaskUsecase implements UseCase<TaskEntity, AddTaskParams> {
  final TaskRepository repository;
  AddTaskUsecase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(AddTaskParams params) {
    return repository.addTask(params.task);
  }
}

class AddTaskParams {
  final TaskEntity task;

  AddTaskParams(this.task);
}
