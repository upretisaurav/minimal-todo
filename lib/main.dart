import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimal_todo/presentation/pages/minimal_todo_app.dart';
import 'config/injector/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.intializeDependencies();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MinimalTodoApp());
}
