import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, [this.code]);

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() =>
      "Failure: $message${code != null ? '{Code: $code}' : ''}";
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, [super.code]);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message, [super.code]);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.code]);
}

class TaskNotFoundFailure extends Failure {
  const TaskNotFoundFailure(String taskId)
    : super("Task with ID $taskId not found", "TASK_NOT_FOUND");
}
