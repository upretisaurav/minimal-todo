import 'package:flutter/material.dart';
import 'package:minimal_todo/config/constants/constants.dart';
import 'package:minimal_todo/presentation/blocs/theme/theme_event.dart';
import 'package:minimal_todo/presentation/blocs/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial()) {
    on<LoadSavedThemeEvent>(_onLoadSavedTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetThemeEvent>(_onSetTheme);
  }

  Future<void> _onLoadSavedTheme(
    LoadSavedThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt(AppConstants.themePreferenceKey) ?? 0;
      final themeMode = ThemeMode.values[themeModeIndex];
      emit(ThemeLoaded(themeMode: themeMode));
    } catch (e) {
      emit(const ThemeLoaded(themeMode: ThemeMode.system));
    }
  }

  Future<void> _onToggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final currentTheme = state.themeMode;
    ThemeMode newTheme;

    switch (currentTheme) {
      case ThemeMode.light:
        newTheme = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newTheme = ThemeMode.system;
        break;
      case ThemeMode.system:
        newTheme = ThemeMode.light;
        break;
    }

    await _saveThemePreference(newTheme);
    emit(ThemeLoaded(themeMode: newTheme));
  }

  Future<void> _onSetTheme(
    SetThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await _saveThemePreference(event.themeMode);
    emit(ThemeLoaded(themeMode: event.themeMode));
  }

  Future<void> _saveThemePreference(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.themePreferenceKey, themeMode.index);
  }
}
