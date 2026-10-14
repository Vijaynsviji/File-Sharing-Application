import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/Avatar.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_setup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetupViewAvatarList extends StatelessWidget {
  const ProfileSetupViewAvatarList({super.key});

  @override
  Widget build(BuildContext context) {
    final profileImageModelList = context
        .select<ProfileSetupViewModel, List<ProfileImageModel>>(
          (viewModel) => viewModel.profileImages,
        );
    final selectedProfileImage = context
        .select<ProfileSetupViewModel, ProfileImageModel>(
          (viewModel) => viewModel.selectedProfile,
        );

    // 1. Calculate how many items go in the first row (e.g., 8 / 2 = 4)
    final int itemsInFirstRow = (profileImageModelList.length / 2).ceil();
    // 2. Calculate remaining items for the second row (handles odd numbers safely)
    final int itemsInSecondRow = profileImageModelList.length - itemsInFirstRow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(context.strings.orPickAStyle, style: context.styles.label),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itemsInFirstRow, (index) {
            final currentImageModel = profileImageModelList[index];
            final isCurrentImageSelected =
                selectedProfileImage.path == currentImageModel.path;
            return GestureDetector(
              child: Avatar(
                profileImageModel: currentImageModel,
                isAvatarSelected: isCurrentImageSelected,
              ),
              onTap: () => {
                context.read<ProfileSetupViewModel>().handleProfileImageChange(
                  currentImageModel,
                ),
              },
            );
          }),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itemsInSecondRow, (index) {
            int indexValue = itemsInFirstRow + index;
            final currentImageModel = profileImageModelList[indexValue];
            final isCurrentImageSelected =
                selectedProfileImage.path == currentImageModel.path;
            return GestureDetector(
              child: Avatar(
                profileImageModel: currentImageModel,
                isAvatarSelected: isCurrentImageSelected,
              ),
              onTap: () => {
                context.read<ProfileSetupViewModel>().handleProfileImageChange(
                  currentImageModel,
                ),
              },
            );
          }),
        ),
      ],
    );
  }
}
