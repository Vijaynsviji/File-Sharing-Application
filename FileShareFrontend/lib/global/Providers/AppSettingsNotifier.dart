import 'package:flutter/material.dart';
import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import '../../core/enums/languageEnums.dart';
import '../../repository/app_settings_repository.dart';

class AppSettingsNotifier extends ChangeNotifier {
  final AppSettingsRepository _repository;

  // 🌟 The single source of truth holds all current setting values
  AppSettings _settings;

  AppSettingsNotifier({
    required AppSettings initialSettings,
    required AppSettingsRepository repository,
  })  : _settings = initialSettings,
        _repository = repository;

  // 🚪 Getters to keep your existing UI code working exactly as before
  ThemeMode get currentTheme => _settings.currentTheme;
  String get currentLanguage => _settings.currentLanguage;

  /// Private helper that saves the internal model state to the SQLite DB
  Future<void> _saveToDatabase() async {
    final result = await _repository.saveAppSettings(_settings);

    if (result is ResourceFailure) {
      debugPrint('Error persisting settings: ${result}');
    }
  }

  /// Toggles between Dark and Light mode
  Future<void> toggleTheme() async {
    final nextTheme = (_settings.currentTheme == ThemeMode.dark)
        ? ThemeMode.light
        : ThemeMode.dark;

    // Mutate the state by assigning a fresh model configuration instance
    _settings = AppSettings(
      id: _settings.id,
      currentTheme: nextTheme,
      currentLanguage: _settings.currentLanguage,
    );

    notifyListeners();
    await _saveToDatabase();
  }

  /// Updates the application language
  Future<void> handleChangeLanguage(LanguageEnums language) async {
    if (_settings.currentLanguage == language.code) return;

    _settings = AppSettings(
      id: _settings.id,
      currentTheme: _settings.currentTheme,
      currentLanguage: language.code,
    );

    notifyListeners();
    await _saveToDatabase();
  }
}
