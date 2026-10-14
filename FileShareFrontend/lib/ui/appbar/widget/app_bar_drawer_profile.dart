import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/core/enums/image_source_enum.dart';
import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../global/models/user_model.dart';
import '../../common/widget/Avatar.dart';
import '../../onboarding/profile_image_model.dart';

class AppBarDrawerProfile extends StatelessWidget {
  const AppBarDrawerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.select<Currentusernotifier, User>(
      (viewModel) => viewModel.currentUser ?? User.dummy,
    );

    final profileImageModel = ProfileImageModel(
      path: currentUser!.profileImage,
      name: '',
      sourceType: ImageSourceType.base64,
    );

    final isLoading = context.select<Currentusernotifier, bool>(
      (viewModel) => viewModel.isLoading,
    );

    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: Column(
        spacing: 10,
        children: [
          Avatar(
            profileImageModel: profileImageModel,
            isAvatarSelected: false,
            width: 150,
            height: 150,
            isLoading: isLoading,
          ),
          Text(currentUser.name, style: context.styles.label),
          Text(currentUser.bio, style: context.styles.subtitle),
        ],
      ),
    );
  }
}
