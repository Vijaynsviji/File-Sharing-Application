import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/circular_avatar.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_setup_view_model.dart';

class ProfileSetupViewAvatar extends StatelessWidget {
  const ProfileSetupViewAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageModel = context
        .select<ProfileSetupViewModel, ProfileImageModel>(
          (viewModel) => viewModel.selectedProfile,
        );
    return GestureDetector(
      onTap: () => {
        context
            .read<ProfileSetupViewModel>()
            .handleProfileImageSelectFromGallery(),
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularAvatar(
            imageModel: profileImageModel,
            width: 150,
            borderWidth: 5,
          ),
          SizedBox(height: 10),
          Text(context.strings.tapToUploadPhoto, style: context.styles.body),
        ],
      ),
    );
  }
}
