import 'package:file_share_application_frontend/ui/common/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/Language/l10n_extensions.dart';
import '../profile_setup_view_model.dart';

class ProfileSetupInfoUserdata extends StatelessWidget {
  const ProfileSetupInfoUserdata({super.key});

  @override
  Widget build(BuildContext context) {
    final profileNameController = context
        .select<ProfileSetupViewModel, TextEditingController>(
          (viewModel) => viewModel.profileName,
        );
    final profileBioController = context
        .select<ProfileSetupViewModel, TextEditingController>(
          (viewModel) => viewModel.profileBio,
        );
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfield(
          label: context.strings.yourName,
          controller: profileNameController,
        ),
        CustomTextfield(
          label: context.strings.bio,
          controller: profileBioController,
          isMultiLine: true,
        ),
      ],
    );
  }
}
