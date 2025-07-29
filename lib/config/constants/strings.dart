class AppStrings {
  static const String appName = 'Minimal Todo App';

  // Error Messages - General
  static const String unexpectedError = 'An unexpected error occurred';

  // Error Messages - Task Specific
  static const String taskNotFound = 'Task not found';
  static const String failedToAddTask = 'Failed to add task';
  static const String failedToUpdateTask = 'Failed to update task';
  static const String failedToDeleteTask = 'Failed to delete task';
  static const String failedToGetTask = 'Failed to get task';

  // Error Messages - Database
  static const String failedToInitializeHive = 'Failed to initialize hive';
  static const String failedToClearAllData = 'Failed to clear all data';
  static const String failedToCloseHiveBoxes = 'Failed to close hive boxes';

  // Priority Labels
  static const String priorityHigh = 'High';
  static const String priorityMedium = 'Medium';
  static const String priorityLow = 'Low';

  // Filter Labels
  static const String filterAll = 'All';
  static const String filterActive = 'Active';
  static const String filterCompleted = 'Completed';
}
