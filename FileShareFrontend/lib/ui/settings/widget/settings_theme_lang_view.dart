import 'package:file_share_application_frontend/ui/settings/widget/setting_theme_lang_save_button.dart';
import 'package:file_share_application_frontend/ui/settings/widget/settings_language_view.dart';
import 'package:file_share_application_frontend/ui/settings/widget/settings_theme_view.dart';
import 'package:flutter/material.dart';

class SettingsThemeLangView extends StatelessWidget {
  const SettingsThemeLangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingsThemeView(),
        Expanded(child: SettingsLanguageView()),
        SettingThemeLangSaveButton(),
      ],
    );
  }
}
