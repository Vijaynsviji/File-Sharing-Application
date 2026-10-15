import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_info_button.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_info_userdata.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_infoview_header.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_infoview_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_image_model.dart';
import '../profile_setup_view_model.dart';

class ProfileUserInfoView extends StatelessWidget {
  const ProfileUserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageModel = context
        .select<ProfileSetupViewModel, ProfileImageModel>(
          (viewModel) => viewModel.selectedProfile,
        );

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 30,
        children: [
          ProfileSetupInfoviewHeader(),
          ProfileSetupInfoviewImage(
            profileImageModel: profileImageModel,
            handleOnClick: () {
              context
                  .read<ProfileSetupViewModel>()
                  .handleProfileImageSelectFromGallery();
            },
          ),
          ProfileSetupInfoUserdata(),
          ProfileSetupInfoButton(),
        ],
      ),
    );
  }
}
