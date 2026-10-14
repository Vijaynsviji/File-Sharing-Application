import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_share_application_frontend/core/enums/languageEnums.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import 'package:file_share_application_frontend/ui/settings/settings_model.dart';
import '../../global/models/user_model.dart';

class SettingsViewModel extends ChangeNotifier {
  late SettingsModel settingsModel; // Make it nullable so it can be initialized
  bool isLoading = true;
  bool isError = false;
  String errorData = "";

  // Inject dependencies through the constructor
  SettingsViewModel({
    required User currentUser,
    required AppSettings currentSettings,
  }) {
    _initializeSettings(currentUser, currentSettings);
  }

  void _initializeSettings(User currentUser, AppSettings settings) {
    try {
      settingsModel = SettingsModel(
        name: currentUser.name,
        bio: currentUser.bio,
        deviceName: currentUser.deviceName,
        themeMode: settings.currentTheme,
        languageEnums:
            LanguageEnums.fromCode(settings.currentLanguage) ??
            LanguageEnums.english,
        profileImage: currentUser.profileImage,
      );

      isLoading = false;
    } catch (e) {
      isError = true;
      errorData = e.toString();
      isLoading = false;
    }
    // No need to call notifyListeners() here since this runs synchronously
    // during instantiation before the UI has even painted.
  }

  void handleChangeTheme(ThemeMode themeMode) {
    settingsModel.themeMode = themeMode;
    notifyListeners();
  }

  void handleChangeLanugae(LanguageEnums language) {
    settingsModel.languageEnums = language;
    notifyListeners();
  }

  void handleSaveSettings(AppSettingsNotifier appSettingsNotifier) {
    try {
      isLoading = true;
      notifyListeners();

      final newAppSettings = AppSettings(
        currentTheme: settingsModel.themeMode,
        currentLanguage: settingsModel.languageEnums.code,
        isFirstTime: appSettingsNotifier.isFirstTime,
      );
      appSettingsNotifier.handleSaveAppSettings(newAppSettings);

      isLoading = false;
    } catch (e) {
      errorData = e.toString();
      isError = true;
    } finally {
      notifyListeners();
    }
  }
}
