import 'package:flutter/material.dart';

class AppSettings {
  final int id;
  final ThemeMode currentTheme;
  final String currentLanguage;

  AppSettings({
    this.id = 1, // Fixed ID ensures we only overwrite a single row of settings
    required this.currentTheme,
    required this.currentLanguage,
  });

  factory AppSettings.fromMap(Map<String, Object?> map) {
    return AppSettings(
      id: map['id'] as int? ?? 1,
      currentTheme: ThemeMode.values.firstWhere(
            (e) => e.name == (map['currentTheme'] as String? ?? 'system'),
        orElse: () => ThemeMode.system,
      ),
      currentLanguage: map['currentLanguage'] as String? ?? 'en',
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'currentTheme': currentTheme.name, // Saves theme as 'system', 'light', or 'dark'
      'currentLanguage': currentLanguage,
    };
  }
}
