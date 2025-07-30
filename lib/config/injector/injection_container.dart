import 'package:get_it/get_it.dart';
import 'package:minimal_todo/data/data_sources/local/hive_service.dart';
import 'package:minimal_todo/data/data_sources/local/task_local_data_source.dart';
import 'package:minimal_todo/data/repositories/task_repository_impl.dart';
import 'package:minimal_todo/domain/repositories/task_repository.dart';
import 'package:minimal_todo/domain/usecases/add_task_usecase.dart';
import 'package:minimal_todo/domain/usecases/delete_task_usecase.dart';
import 'package:minimal_todo/domain/usecases/get_task_by_id_usecase.dart';
import 'package:minimal_todo/domain/usecases/get_tasks_usecase.dart';
import 'package:minimal_todo/domain/usecases/toggle_task_completion_usecase.dart';
import 'package:minimal_todo/domain/usecases/update_task_usecase.dart';
import 'package:minimal_todo/presentation/blocs/filter/filter_bloc.dart';
import 'package:minimal_todo/presentation/blocs/task/task_bloc.dart';
import 'package:minimal_todo/presentation/blocs/theme/theme_bloc.dart';
import 'package:minimal_todo/routes/app_route_conf.dart';

final getIt = GetIt.instance;

Future<void> intializeDependencies() async {
  getIt.registerLazySingleton<HiveService>(() => HiveServiceImpl());

  await getIt<HiveService>().init();

  // External
  getIt.registerLazySingleton(() => AppRouteConf().router);
  getIt.registerLazySingleton(() => AppRouteConf());

  // Data Sources
  getIt.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(getIt<HiveService>()),
  );

  // Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt<TaskLocalDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => GetTasksUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
    () => GetTaskByIdUseCase(getIt<TaskRepository>()),
  );
  getIt.registerLazySingleton(() => UpdateTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => DeleteTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(
    () => ToggleTaskCompletionUseCase(getIt<TaskRepository>()),
  );

  // Blocs
  getIt.registerFactory(() => ThemeBloc());
  getIt.registerFactory(
    () => TaskBloc(
      getTasksUseCase: getIt<GetTasksUseCase>(),
      getTaskByIdUseCase: getIt<GetTaskByIdUseCase>(),
      addTaskUseCase: getIt<AddTaskUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
      toggleTaskCompletionUseCase: getIt<ToggleTaskCompletionUseCase>(),
      deleteTaskUseCase: getIt<DeleteTaskUseCase>(),
    ),
  );
  getIt.registerFactory(() => FilterBloc());
}
