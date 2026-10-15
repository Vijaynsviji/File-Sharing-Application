import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/ui/AppScaffold.dart';
import 'package:file_share_application_frontend/ui/settings/settings_enums.dart';
import 'package:file_share_application_frontend/ui/settings/settings_view_model.dart';
import 'package:file_share_application_frontend/ui/settings/widget/setting_profile_view.dart';
import 'package:file_share_application_frontend/ui/settings/widget/settings_theme_lang_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global/Providers/CurrentUserNotifier.dart';
import '../../global/models/user_model.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewEnum currentView;
  const SettingsView({super.key, required this.currentView});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<Currentusernotifier>();
    final currentSettings = context.read<AppSettingsNotifier>();

    // 2. Safely initialize your secondary view model layout logic block
    final settingViewModel = SettingsViewModel(
      currentUser: currentUser.currentUser ?? User.dummy,
      currentSettings: currentSettings.appSettings,
    );

    final isProfileSettingsView = currentView == SettingsViewEnum.profileView;

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          context.strings.appearanceAndLanguage,
          style: context.styles.secondaryHeader,
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: settingViewModel,
        child: isProfileSettingsView
            ? SettingProfileView()
            : SettingsThemeLangView(),
      ),
    );
  }
}
