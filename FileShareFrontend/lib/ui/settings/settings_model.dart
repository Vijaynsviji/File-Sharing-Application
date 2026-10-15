import 'package:file_share_application_frontend/core/enums/languageEnums.dart';
import 'package:flutter/material.dart';

class SettingsModel {
  final ThemeMode themeMode;
  final LanguageEnums languageEnums;
  final String profileImage;

  SettingsModel({
    required this.themeMode,
    required this.languageEnums,
    required this.profileImage,
  });

  SettingsModel copyWith({
    ThemeMode? themeMode,
    LanguageEnums? languageEnums,
    String? profileImage,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      languageEnums: languageEnums ?? this.languageEnums,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}
