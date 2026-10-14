import 'package:flutter/material.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_view_avatar.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_view_avatar_list.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_view_button_section.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_view_header.dart';

class ProfileImagePickView extends StatelessWidget {
  const ProfileImagePickView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProfileSetupViewHeader(),
        SizedBox(height: 10),
        ProfileSetupViewAvatar(),
        SizedBox(height: 10),
        ProfileSetupViewAvatarList(),
        SizedBox(height: 10),
        ProfileSetupViewButtonSection(),
      ],
    );
  }
}
