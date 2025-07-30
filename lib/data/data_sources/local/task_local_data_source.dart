import 'package:minimal_todo/config/constants/strings.dart';
import 'package:minimal_todo/core/error/exceptions.dart';
import 'package:minimal_todo/data/data_sources/local/hive_service.dart';
import 'package:minimal_todo/data/models/task_filter_model.dart';
import 'package:minimal_todo/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks({TaskFilterModel? filter});
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> addTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<bool> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final HiveService hiveService;

  TaskLocalDataSourceImpl(this.hiveService);

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final box = await hiveService.getTaskBox();
      await box.put(task.id, task);
      return task;
    } catch (e) {
      throw DatabaseException('${AppStrings.failedToAddTask}: $e');
    }
  }

  @override
  Future<bool> deleteTask(String id) async {
    try {
      final box = await hiveService.getTaskBox();

      if (!box.containsKey(id)) {
        throw TaskNotFoundException(id);
      }

      await box.delete(id);
      return true;
    } catch (e) {
      if (e is TaskNotFoundException) {
        rethrow;
      }
      throw DatabaseException('${AppStrings.failedToDeleteTask}: $e');
    }
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    try {
      final box = await hiveService.getTaskBox();
      final task = box.values.firstWhere(
        (task) => task.id == id,
        orElse: () => throw TaskNotFoundException(id),
      );
      return task;
    } catch (e) {
      if (e is TaskNotFoundException) {
        rethrow;
      }
      throw DatabaseException('${AppStrings.failedToGetTask} by id: $e');
    }
  }

  @override
  Future<List<TaskModel>> getTasks({TaskFilterModel? filter}) async {
    try {
      final box = await hiveService.getTaskBox();
      List<TaskModel> allTasks = box.values.toList();

      if (filter != null) {
        allTasks = _applyFilter(allTasks, filter);
      }

      allTasks.sort((a, b) {
        if (a.dueDate != null && b.dueDate != null) {
          return a.dueDate!.compareTo(b.dueDate!);
        }
        if (a.dueDate != null && b.dueDate == null) {
          return -1;
        }

        if (a.dueDate == null && b.dueDate != null) {
          return 1;
        }

        return a.createdAt.compareTo(b.createdAt);
      });
      return allTasks;
    } catch (e) {
      throw DatabaseException('${AppStrings.failedToGetTask}s: $e');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      final box = await hiveService.getTaskBox();

      if (!box.containsKey(task.id)) {
        throw TaskNotFoundException(task.id);
      }

      await box.put(task.id, task);
      return task;
    } catch (e) {
      if (e is TaskNotFoundException) {
        rethrow;
      }
      throw DatabaseException('${AppStrings.failedToUpdateTask}: $e');
    }
  }

  List<TaskModel> _applyFilter(List<TaskModel> tasks, TaskFilterModel filter) {
    List<TaskModel> filteredTasks = tasks;

    switch (filter.filter) {
      case 'active':
        filteredTasks =
            filteredTasks.where((task) => !task.isCompleted).toList();
        break;
      case 'completed':
        filteredTasks =
            filteredTasks.where((task) => task.isCompleted).toList();
        break;
      case 'all':
      default:
        break;
    }

    if (filter.startDate != null) {
      filteredTasks =
          filteredTasks.where((task) {
            return task.createdAt.isAfter(filter.startDate!) ||
                task.createdAt.isAtSameMomentAs((filter.startDate!));
          }).toList();
    }

    if (filter.endDate != null) {
      filteredTasks =
          filteredTasks.where((task) {
            return task.createdAt.isBefore(filter.endDate!) ||
                task.createdAt.isAtSameMomentAs((filter.endDate!));
          }).toList();
    }

    return filteredTasks;
  }
}
