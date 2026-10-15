import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:file_share_application_frontend/ui/common/widget/custom_textfield.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsProfileUserInfoView extends StatelessWidget {
  const SettingsProfileUserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserNotifier = context.read<Currentusernotifier>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        CustomTextfield(
          label: context.strings.yourName,
          controller: context.select<SettingsViewModel, TextEditingController>(
            (viewModel) => viewModel.nameController,
          ),
        ),
        CustomTextfield(
          label: context.strings.bio,
          controller: context.select<SettingsViewModel, TextEditingController>(
            (viewModel) => viewModel.bioController,
          ),
          isMultiLine: true,
        ),
        CustomTextfield(
          label: context.strings.deviceName,
          controller: context.select<SettingsViewModel, TextEditingController>(
            (viewModel) => viewModel.deviceNameController,
          ),
        ),
        PrimaryButtonCustom(
          text: context.strings.saveChanges,
          onPressed: () {
            context.read<SettingsViewModel>().handleSaveProfileSettings(
              currentUserNotifier,
            );
          },
        ),
      ],
    );
  }
}
