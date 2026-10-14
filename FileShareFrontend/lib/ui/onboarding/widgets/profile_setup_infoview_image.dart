import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/circular_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_image_model.dart';
import '../profile_setup_view_model.dart';

class ProfileSetupInfoviewImage extends StatelessWidget {
  const ProfileSetupInfoviewImage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageModel = context
        .select<ProfileSetupViewModel, ProfileImageModel>(
          (viewModel) => viewModel.selectedProfile,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        CircularAvatar(imageModel: profileImageModel, width: 100),
        GestureDetector(
          onTap: () => {
            context
                .read<ProfileSetupViewModel>()
                .handleProfileImageSelectFromGallery(),
          },
          child: Text(context.strings.changePhoto, style: context.styles.link),
        ),
      ],
    );
  }
}
