import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/settings/widget/settings_theme_card_view.dart';
import 'package:flutter/material.dart';

class SettingsThemeView extends StatelessWidget {
  const SettingsThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Text(context.strings.theme, style: context.styles.label),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5,
          children: [
            SettingsThemeCardView(themeMode: ThemeMode.light),
            SettingsThemeCardView(themeMode: ThemeMode.dark),
            SettingsThemeCardView(themeMode: ThemeMode.system),
          ],
        ),
      ],
    );
  }
}
