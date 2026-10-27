import 'package:file_share_application_frontend/core/enums/image_source_enum.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/global/models/user_model.dart';
import 'package:file_share_application_frontend/ui/common/widget/Avatar.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/Language/l10n_extensions.dart';
import '../../global/Providers/CurrentUserNotifier.dart';
import '../settings/settings_enums.dart';
import '../settings/settings_view.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserData = context.select<Currentusernotifier, User>(
      (viewModel) => viewModel.currentUser ?? User.dummy,
    ); // final currentUserData = User.dummy;
    final profileImageModel = ProfileImageModel(
      path: currentUserData!.profileImage,
      name: '',
      sourceType: ImageSourceType.base64,
    );
    final isLoading = context.select<Currentusernotifier, bool>(
      (viewModel) => viewModel.isLoading,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Badge(
        //   backgroundColor: Colors.cyan,
        //   smallSize: 8.0,
        //   child: Icon(Icons.sort, color: context.colors.ink),
        // ),
        // Icon(Icons.menu, color: context.colors.ink),
        Text(context.strings.homeTitle),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) =>
                    SettingsView(currentView: SettingsViewEnum.profileView),
              ),
            );
          },
          child: Avatar(
            profileImageModel: profileImageModel,
            isAvatarSelected: false,
            width: 35,
            height: 35,
            isLoading: isLoading,
          ),
        ),
      ],
    );
  }
}
