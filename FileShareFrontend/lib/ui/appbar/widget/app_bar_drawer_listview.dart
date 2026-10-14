import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/appbar/widget/app_bar_drawer_list_tile.dart';
import 'package:file_share_application_frontend/ui/settings/settings_enums.dart';
import 'package:file_share_application_frontend/ui/settings/settings_view.dart';
import 'package:flutter/material.dart';

import '../../../global/models/app_colors.dart';

class AppBarDrawerListview extends StatelessWidget {
  const AppBarDrawerListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: context.colors.line),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBarDrawerListTile(
            iconData: Icons.settings,
            tileMainText: context.strings.settings,
            tileViewType: SettingsViewEnum.themeAndLangView,
            handleClick: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => SettingsView(
                    currentView: SettingsViewEnum.themeAndLangView,
                  ),
                ),
              );
            },
          ),
          AppBarDrawerListTile(
            iconData: Icons.edit,
            tileMainText: context.strings.editProfile,
            tileViewType: SettingsViewEnum.profileView,
            handleClick: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>
                      SettingsView(currentView: SettingsViewEnum.profileView),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
