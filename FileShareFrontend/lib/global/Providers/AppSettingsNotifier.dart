import 'package:flutter/material.dart';
import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import '../../core/enums/languageEnums.dart';
import '../../repository/app_settings_repository.dart';

class AppSettingsNotifier extends ChangeNotifier {
  final AppSettingsRepository _repository;

  // 🌟 The single source of truth holds all current setting values
  AppSettings _settings;
  bool _isLoading = true;
  bool _isError = false;

  AppSettingsNotifier({
    required AppSettingsRepository repository,
    required AppSettings settings,
  }) : _settings = settings,
       _repository = repository {}

  // 🚪 Getters to keep your existing UI code working exactly as before
  AppSettings get appSettings => _settings;
  AppSettingsRepository get appSettingsRepo => _repository;
  ThemeMode get currentTheme => _settings.currentTheme;
  String get currentLanguage => _settings.currentLanguage;
  bool get isFirstTime => _settings.isFirstTime;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  // Future<void> _loadSettingsFromDB() async {
  //   try {
  //     final settingsData = await _repository.getAppSettings();
  //     if (settingsData is ResourceFailure) {
  //       throw ("Not able to fetch Settings Data");
  //     }
  //
  //     final succededData = settingsData as ResourceSuccess<AppSettings>;
  //     final parsedData = succededData.data;
  //     _settings = parsedData;
  //   } catch (e) {
  //     _isError = true;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  /// Private helper that saves the internal model state to the SQLite DB
  Future<void> saveToDatabase(AppSettings settings) async {
    final result = await _repository.saveAppSettings(settings);
    _settings = settings;
    notifyListeners();
    if (result is ResourceFailure) {
      debugPrint('Error persisting settings: ${result}');
    }
  }

  bool isSettingsDataInitialised() {
    return !_isLoading && !_isError;
  }

  Future<void> handleSaveAppSettings(AppSettings settings) async {
    toggleTheme(settings.currentTheme);
    final language = LanguageEnums.fromCode(settings.currentLanguage);
    if (language != null) {
      handleChangeLanguage(language);
    }
    await saveToDatabase(_settings);
  }

  /// Toggles between Dark and Light mode
  Future<void> toggleTheme(ThemeMode themeMode) async {
    // final nextTheme = (_settings.currentTheme == ThemeMode.dark)
    //     ? ThemeMode.light
    //     : ThemeMode.dark;

    // Mutate the state by assigning a fresh model configuration instance
    _settings = AppSettings(
      id: _settings.id,
      currentTheme: themeMode,
      currentLanguage: _settings.currentLanguage,
      isFirstTime: _settings.isFirstTime,
    );

    // notifyListeners();
    // await saveToDatabase(_settings);
  }

  /// Updates the application language
  Future<void> handleChangeLanguage(LanguageEnums language) async {
    if (_settings.currentLanguage == language.code) return;

    _settings = AppSettings(
      id: _settings.id,
      currentTheme: _settings.currentTheme,
      currentLanguage: language.code,
      isFirstTime: _settings.isFirstTime,
    );

    // notifyListeners();
    // await saveToDatabase(_settings);
  }
}
