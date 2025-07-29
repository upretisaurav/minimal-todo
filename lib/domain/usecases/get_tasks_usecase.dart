import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/core/usecases/base_usecase.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class GetTasksUsecase implements UseCase<List<TaskEntity>, GetTasksParams> {
  final TaskRepository repository;

  GetTasksUsecase(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(GetTasksParams params) {
    return repository.getTasks(filter: params.filter);
  }
}

class GetTasksParams {
  final TaskFilterEntity? filter;

  GetTasksParams({this.filter});
}
