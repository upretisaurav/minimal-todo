import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimal_todo/config/constants/constants.dart';
import 'package:minimal_todo/config/constants/strings.dart';
import 'package:minimal_todo/core/error/exceptions.dart';
import 'package:minimal_todo/data/models/task_model.dart';

abstract class HiveService {
  Future<void> init();
  Future<Box<TaskModel>> getTaskBox();
  Future<void> clearAllData();
  Future<void> closeBoxes();
}

class HiveServiceImpl implements HiveService {
  Box<TaskModel>? _taskBox;

  @override
  Future<void> init() async {
    try {
      await Hive.initFlutter();

      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskModelAdapter());
      }

      _taskBox = await Hive.openBox<TaskModel>(AppConstants.hiveBoxName);
    } catch (e) {
      throw DatabaseException('${AppStrings.failedToInitializeHive}: $e');
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      final box = await getTaskBox();
      await box.clear();
    } catch (e) {
      throw DatabaseException('${AppStrings.failedToClearAllData}: $e');
    }
  }

  @override
  Future<void> closeBoxes() async {
    try {
      await _taskBox?.close();
    } catch (e) {
      throw DatabaseException('${AppStrings.failedToCloseHiveBoxes}: $e');
    }
  }

  @override
  Future<Box<TaskModel>> getTaskBox() async {
    if (_taskBox == null || !_taskBox!.isOpen) {
      _taskBox = await Hive.openBox<TaskModel>(AppConstants.hiveBoxName);
    }
    return _taskBox!;
  }
}
