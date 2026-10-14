import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:file_share_application_frontend/repository/app_settings_repository.dart';
import 'package:file_share_application_frontend/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/Language/l10n_extensions.dart';
import '../../common/widget/primary_button_custom.dart';
import '../profile_setup_view_model.dart';

class ProfileSetupInfoButton extends StatelessWidget {
  const ProfileSetupInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingsData = context.watch<AppSettingsNotifier>();
    final userData = context.watch<Currentusernotifier>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 30,
      children: [
        PrimaryButtonCustom(
          text: context.strings.finishSetup,
          onPressed: () => {
            context.read<ProfileSetupViewModel>().handleFinishProfileSettings(
              appSettingsData,
              appSettingsData.appSettingsRepo,
              userData,
            ),
          },
        ),
        Center(
          child: Text(
            context.strings.editAnytimeNote,
            style: context.styles.body,
          ),
        ),
      ],
    );
  }
}
