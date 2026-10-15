import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_share_application_frontend/core/enums/languageEnums.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import 'package:file_share_application_frontend/ui/settings/settings_model.dart';
import '../../core/Utils/image_picker.dart';
import '../../core/notifications/notification_service.dart';
import '../../global/models/user_model.dart';
import '../onboarding/profile_setup_service.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsModel? _settingsModel;

  // Make it nullable so it can be initialized
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _deviceNameController = TextEditingController();
  bool _isLoading = true;
  bool _isError = false;
  String _errorData = "";

  // Inject dependencies through the constructor
  SettingsViewModel({
    required User currentUser,
    required AppSettings currentSettings,
  }) {
    _initializeSettings(currentUser, currentSettings);
  }

  SettingsModel? get settingsModel => _settingsModel;

  void _initializeSettings(User currentUser, AppSettings settings) {
    try {
      _settingsModel = SettingsModel(
        // name: currentUser.name,
        // bio: currentUser.bio,
        // deviceName: currentUser.deviceName,
        themeMode: settings.currentTheme,
        languageEnums:
            LanguageEnums.fromCode(settings.currentLanguage) ??
            LanguageEnums.english,
        profileImage: currentUser.profileImage,
      );

      _nameController.text = currentUser.name;
      _deviceNameController.text = currentUser.deviceName;
      _bioController.text = currentUser.bio;
      _isLoading = false;
    } catch (e) {
      _isError = true;
      _errorData = e.toString();
      _isLoading = false;
    }
    // No need to call notifyListeners() here since this runs synchronously
    // during instantiation before the UI has even painted.
  }

  void handleChangeTheme(ThemeMode themeMode) {
    _settingsModel = _settingsModel?.copyWith(themeMode: themeMode);
    notifyListeners();
  }

  void handleChangeLanugae(LanguageEnums language) {
    _settingsModel = _settingsModel?.copyWith(languageEnums: language);
    notifyListeners();
  }

  void handleSaveSettings(AppSettingsNotifier appSettingsNotifier) {
    try {
      if (_settingsModel == null) return;
      _isLoading = true;
      notifyListeners();

      final newAppSettings = AppSettings(
        currentTheme: _settingsModel!.themeMode,
        currentLanguage: _settingsModel!.languageEnums.code,
        isFirstTime: appSettingsNotifier.isFirstTime,
      );
      appSettingsNotifier.handleSaveAppSettings(newAppSettings);
      _isLoading = false;
      notifyListeners();
      NotificationService.showSuccessDialog('settings saved successfully!');
    } catch (e) {
      _errorData = e.toString();
      _isError = true;
      notifyListeners();
      NotificationService.showSuccessDialog('Failed to save settings');
    }
  }

  bool get isLoading => _isLoading;

  bool get isError => _isError;

  String get errorData => _errorData;

  void handleProfileImageSelectFromGallery() async {
    try {
      final file = await ProfileImageManager().pickImageFromGallery();
      if (file != null) {
        final profileImageBaseString = await convertAssetToBase64(file);
        _settingsModel = _settingsModel?.copyWith(
          profileImage: profileImageBaseString,
        );
        // ProfileImageModel profileImageModel = ProfileImageModel(
        //   path: file.path,
        //   name: Path.basename(file.path),
        //   isAsset: false,
        // );
        // handleProfileImageChange(profileImageModel);
      }
    } catch (e) {
      print("Not able to read file from the Gallery");
      NotificationService.showError("Not able to read file from the Gallery");
    } finally {
      notifyListeners();
    }
  }

  void handleSaveProfileSettings(
    Currentusernotifier currentUserNotifier,
  ) async {
    try {
      if (_settingsModel == null) return;
      final updatedUserValue = currentUserNotifier.currentUser?.copyWith(
        deviceName: _deviceNameController.value.text,
        name: _nameController.value.text,
        bio: _bioController.value.text,
        profileImage:
            _settingsModel?.profileImage ??
            currentUserNotifier.currentUser?.profileImage,
      );

      if (updatedUserValue != null) {
        await currentUserNotifier.saveUserData(updatedUserValue);
      }
      notifyListeners();
      NotificationService.showSuccessDialog(
        'profile settings saved successfully!',
      );
    } catch (e) {
      NotificationService.showErrorDialog('failed to save profile settings');
      notifyListeners();
    }
  }

  TextEditingController get bioController => _bioController;

  TextEditingController get deviceNameController => _deviceNameController;
  TextEditingController get nameController => _nameController;
}
