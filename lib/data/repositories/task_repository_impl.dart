import 'package:dartz/dartz.dart';
import 'package:minimal_todo/config/constants/strings.dart';
import 'package:minimal_todo/core/error/exceptions.dart';
import 'package:minimal_todo/core/error/failures.dart';
import 'package:minimal_todo/data/data_sources/local/task_local_data_source.dart';
import 'package:minimal_todo/data/models/task_filter_model.dart';
import 'package:minimal_todo/data/models/task_model.dart';
import 'package:minimal_todo/domain/entities/task_entity.dart';
import 'package:minimal_todo/domain/entities/task_filter_entity.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, TaskEntity>> addTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final addedTaskModel = await localDataSource.addTask(taskModel);
      return Right(addedTaskModel.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message, e.code));
    } catch (e) {
      return Left(DatabaseFailure('${AppStrings.unexpectedError}: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(String id) async {
    try {
      final result = await localDataSource.deleteTask(id);
      return Right(result);
    } on TaskNotFoundException {
      return Left(TaskNotFoundFailure(id));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message, e.code));
    } catch (e) {
      return Left(DatabaseFailure('${AppStrings.unexpectedError}: $e'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTaskById(String id) async {
    try {
      final result = await localDataSource.getTaskById(id);
      return Right(result.toEntity());
    } on TaskNotFoundException {
      return Left(TaskNotFoundFailure(id));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message, e.code));
    } catch (e) {
      return Left(DatabaseFailure('${AppStrings.unexpectedError}: $e'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks({
    TaskFilterEntity? filter,
  }) async {
    try {
      TaskFilterModel? filterModel;
      if (filter != null) {
        filterModel = TaskFilterModel.fromEntity(filter);
      }
      final taskModels = await localDataSource.getTasks(filter: filterModel);
      final taskEntities = taskModels.map((model) => model.toEntity()).toList();
      return Right(taskEntities);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message, e.code));
    } catch (e) {
      return Left(DatabaseFailure('${AppStrings.unexpectedError}: $e'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(TaskEntity task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTaskModel = await localDataSource.updateTask(taskModel);
      return Right(updatedTaskModel.toEntity());
    } on TaskNotFoundException {
      return Left(TaskNotFoundFailure(task.id));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message, e.code));
    } catch (e) {
      return Left(DatabaseFailure('${AppStrings.unexpectedError}: $e'));
    }
  }
}
