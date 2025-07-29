class Path {
  static const String home = "/home";
  static const String splash = "/splash";
}

enum AppRoute {
  home(Path.home),
  splash(Path.splash);

  final String path;
  const AppRoute(this.path);
}
