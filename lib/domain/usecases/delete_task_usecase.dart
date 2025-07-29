import 'package:dartz/dartz.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/core/usecases/base_usecase.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class DeleteTaskUseCase implements UseCase<bool, DeleteTaskParams> {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteTaskParams params) {
    return repository.deleteTask(params.taskId);
  }
}

class DeleteTaskParams {
  final String taskId;

  DeleteTaskParams({required this.taskId});
}
