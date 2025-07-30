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

  // Task Fields
  static const String title = 'Title';
  static const String description = 'Description';
  static const String dueDate = 'Due Date';
  static const String priority = 'Priority';
  static const String status = 'Status';

  // Task Actions
  static const String addTask = 'Add Task';
  static const String editTask = 'Edit Task';
  static const String deleteTask = 'Delete Task';
  static const String markComplete = 'Mark Complete';
  static const String markIncomplete = 'Mark Incomplete';
  static const String saveTask = 'Save Task';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String confirm = 'Confirm';

  // Empty States
  static const String noTasksYet = 'No tasks yet';
  static const String addFirstTask = 'Add your first task to get started';
  static const String allTasksCompleted = 'All tasks completed! 🎉';

  // Confirmation Messages
  static const String deleteTaskConfirmation =
      'Are you sure you want to delete this task?';
  static const String taskDeleted = 'Task deleted';
  static const String taskAdded = 'Task added';
  static const String taskUpdated = 'Task updated';
  static const String taskCompleted = 'Task completed';
  static const String taskReopened = 'Task reopened';
}
