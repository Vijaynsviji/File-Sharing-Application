import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingThemeLangSaveButton extends StatelessWidget {
  const SettingThemeLangSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonCustom(
      text: context.strings.saveChanges,
      onPressed: () {
        final appSettingsNotifier = context.read<AppSettingsNotifier>();
        context.read<SettingsViewModel>().handleSaveSettings(
          appSettingsNotifier,
        );
      },
    );
  }
}
