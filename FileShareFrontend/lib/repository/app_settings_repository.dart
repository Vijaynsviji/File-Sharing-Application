import 'package:file_share_application_frontend/core/Utils/resourceWrapper.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart'; // Adjust mapping path as needed
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AppSettingsRepository {
  final Database database;
  final String tableName = "AppSettings";

  AppSettingsRepository({required this.database});

  // GET SETTINGS
  Future<Resource<AppSettings>> getAppSettings() async {
    try {
      final List<Map<String, Object?>> settingsData = await database.query(
        tableName,
        where: 'id = ?',
        whereArgs: [1],
      );

      // If no settings exist yet (first-time launch), return a default state configuration
      if (settingsData.isEmpty) {
        final defaultSettings = AppSettings(
          currentTheme: ThemeMode.system,
          currentLanguage: 'en',
        );
        return ResourceSuccess(defaultSettings);
      }

      final AppSettings parsedSettings = AppSettings.fromMap(settingsData.first);
      return ResourceSuccess(parsedSettings);
    } catch (e) {
      return ResourceFailure('Failed to fetch app settings data', exception: e as Exception);
    }
  }

  // SAVE OR UPDATE SETTINGS
  Future<Resource<bool>> saveAppSettings(AppSettings settings) async {
    try {
      // ConflictAlgorithm.replace automatically acts as an "Upsert" (inserts or replaces)
      await database.insert(
        tableName,
        settings.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return ResourceSuccess(true);
    } catch (e) {
      return ResourceFailure('Failed to save app settings data', exception: e as Exception);
    }
  }

// HELPER MIGRATION/CREATION BLOCK (For reference inside your database open helper code)
// SQL Statement to run when setting up tables:
// CREATE TABLE AppSettings (id INTEGER PRIMARY KEY, currentTheme TEXT, currentLanguage TEXT)
}
