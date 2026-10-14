import 'package:file_share_application_frontend/ui/onboarding/profile_setup_model.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_setup_view_model.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_image_pick_view.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_setup_pageview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({super.key});

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final ProfileSetupViewModel profileSetupViewModel = ProfileSetupViewModel(
    ProfileSetupModel(),
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => profileSetupViewModel,
      child: const ProfileSetupPageview(),
    );
  }
}
