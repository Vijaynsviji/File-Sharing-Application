import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/DiscoveryNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/PeerDeviceNotifier.dart';
import 'package:file_share_application_frontend/repository/app_settings_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../repository/peer_device_repository.dart';
import '../../repository/user_repository.dart';
import '../models/app_dependencies.dart';
import '../models/app_settings.dart';
import 'CurrentUserNotifier.dart';
import 'EngineNotifier.dart';
import 'FileNotifiers.dart';
import 'FileTransferNotifier.dart';

class AppProviders {
  static List<SingleChildWidget> getProviders(AppDependencies dependencies) {
    return [
      // Inject initialized data/repos
      ChangeNotifierProvider<AppSettingsNotifier>.value(
        value: dependencies.appSettings,
      ),
      // Provider<AppSettingsRepository>.value(
      //   value: dependencies.appSettingsRepository,
      // ),
      ChangeNotifierProvider<Currentusernotifier>.value(
        value: dependencies.userData,
      ),
      ChangeNotifierProvider<PeerDeviceNotifier>.value(
        value: dependencies.peerDeviceData,
      ),

      // Inject Notifiers
      ChangeNotifierProvider<Filenotifiers>(
        create: (context) => Filenotifiers(),
      ),
      ChangeNotifierProvider<Discoverynotifier>.value(
        value: dependencies.discoveryData,
      ),
      ChangeNotifierProvider<Filetransfernotifier>(
        create: (context) => Filetransfernotifier(),
      ),
      ChangeNotifierProvider<EngineNotifier>(
        create: (context) =>
            EngineNotifier(dependencies.discoveryData, dependencies.userData),
      ),
    ];
  }
}
