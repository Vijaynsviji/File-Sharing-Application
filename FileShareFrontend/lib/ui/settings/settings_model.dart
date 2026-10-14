import 'package:file_share_application_frontend/core/enums/languageEnums.dart';
import 'package:flutter/material.dart';

class SettingsModel {
  String name;
  String bio;
  String deviceName;
  ThemeMode themeMode;
  LanguageEnums languageEnums;
  String profileImage;

  SettingsModel({
    required this.name,
    required this.bio,
    required this.deviceName,
    required this.themeMode,
    required this.languageEnums,
    required this.profileImage,
  });
}
