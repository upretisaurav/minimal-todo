class TaskValidators {
  static String? validateTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'Title is required';
    }
    if (title.trim().length > 100) {
      return 'Title must be less than 100 characters';
    }
    return null;
  }

  static String? validateDescription(String? description) {
    if (description != null && description.length > 500) {
      return 'Description must be less than 500 characters';
    }
    return null;
  }

  static String? validateDueDate(DateTime? dueDate) {
    if (dueDate != null &&
        dueDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return 'Due date cannot be in the past';
    }
    return null;
  }
}
