import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/PeerDeviceNotifier.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import 'package:file_share_application_frontend/global/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/Utils/resourceWrapper.dart';
import '../../repository/app_settings_repository.dart';
import '../../repository/database_helper.dart';
import '../../repository/peer_device_repository.dart';
import '../../repository/user_repository.dart';
import '../Providers/AppSettingsNotifier.dart';
import '../Providers/DiscoveryNotifier.dart';

// A simple container to hold everything we initialize
class AppDependencies {
  final AppSettingsNotifier appSettings;
  // final AppSettingsRepository appSettingsRepository;
  // final UserRepository userRepository;
  final Currentusernotifier userData;
  // final PeerDeviceRepository peerDeviceRepository;
  final PeerDeviceNotifier peerDeviceData;
  final Discoverynotifier discoveryData;

  AppDependencies({
    required this.appSettings,
    required this.userData,
    // required this.peerDeviceRepository,
    // required this.appSettingsRepository,
    required this.peerDeviceData,
    required this.discoveryData,
  });

  // This function does all the heavy lifting
  static Future<AppDependencies?> initialize() async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      Database database = await databaseHelper.database;

      AppSettingsRepository settingsRepo = AppSettingsRepository(
        database: database,
      );
      UserRepository userRepo = UserRepository(database: database);
      PeerDeviceRepository peerRepo = PeerDeviceRepository(database: database);

      Resource<AppSettings> appSettingsResult = await settingsRepo
          .getAppSettings();

      if (appSettingsResult is ResourceFailure) {
        return null; // Initialization failed
      }

      final parsedSettingsData =
          (appSettingsResult as ResourceSuccess<AppSettings>).data;

      final appSettingsData = AppSettingsNotifier(
        repository: settingsRepo,
        settings: parsedSettingsData,
      );
      final currentUserData = Currentusernotifier(repository: userRepo);
      final peerDeviceData = PeerDeviceNotifier(repository: peerRepo);
      final discoveryData = Discoverynotifier(repository: peerRepo);

      return AppDependencies(
        appSettings: appSettingsData,
        userData: currentUserData,
        peerDeviceData: peerDeviceData,
        discoveryData: discoveryData,
        // appSettingsRepository: settingsRepo,
      );
    } catch (e) {
      debugPrint("Database Initialization Error: $e");
      return null;
    }
  }
}
