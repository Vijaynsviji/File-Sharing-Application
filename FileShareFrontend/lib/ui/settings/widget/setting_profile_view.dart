import 'package:file_share_application_frontend/core/enums/image_source_enum.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_image_pick_view.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_infoview_image.dart';
import 'package:file_share_application_frontend/ui/settings/settings_model.dart';
import 'package:file_share_application_frontend/ui/settings/widget/settings_profile_user_info_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../onboarding/profile_image_model.dart';
import '../settings_view_model.dart';

class SettingProfileView extends StatelessWidget {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final String profileImageBase64 = context.select<SettingsViewModel, String>(
      (viewModel) => viewModel.settingsModel!.profileImage,
    );

    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20,
          children: [
            ProfileSetupInfoviewImage(
              profileImageModel: ProfileImageModel(
                path: profileImageBase64,
                name: '',
                sourceType: ImageSourceType.base64,
              ),
              handleOnClick: () {
                context
                    .read<SettingsViewModel>()
                    .handleProfileImageSelectFromGallery();
              },
            ),
            SettingsProfileUserInfoView(),
          ],
        ),
      ),
    );
  }
}
