abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() =>
      "AppException: $message${code != null ? '{Code: $code}' : ''}";
}

class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.code]);
}

class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}

class CacheException extends AppException {
  const CacheException(super.message, [super.code]);
}

class TaskNotFoundException extends AppException {
  const TaskNotFoundException(String taskId)
    : super("Task with ID $taskId not found", "TASK_NOT_FOUND");
}
