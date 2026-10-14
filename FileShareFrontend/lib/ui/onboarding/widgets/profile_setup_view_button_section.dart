import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/common/widget/secondary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_setup_view_model.dart';

class ProfileSetupViewButtonSection extends StatelessWidget {
  const ProfileSetupViewButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        PrimaryButtonCustom(
          text: context.strings.continueButton,
          onPressed: () {
            context.read<ProfileSetupViewModel>().handleChangePageView(1);
          },
          buttonBorderRadius: 10,
        ),
        SecondaryTextButton(
          text: context.strings.illDoThisLater,
          onPressed: () {
            context.read<ProfileSetupViewModel>().handleChangePageView(1);
          },
        ),
      ],
    );
  }
}
