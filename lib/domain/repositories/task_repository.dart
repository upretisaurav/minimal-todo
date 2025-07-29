import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks({
    TaskFilterEntity? filter,
  });
  Future<Either<Failure, TaskEntity>> getTaskById(String id);
  Future<Either<Failure, TaskEntity>> addTask(TaskEntity task);
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task);
  Future<Either<Failure, bool>> deleteTask(String id);
}
