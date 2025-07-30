class Path {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String addEditTask = '/add-edit-task';
}

enum AppRoute {
  home(Path.home),
  splash(Path.splash),
  addEditTask(Path.addEditTask);

  final String path;
  const AppRoute(this.path);
}
