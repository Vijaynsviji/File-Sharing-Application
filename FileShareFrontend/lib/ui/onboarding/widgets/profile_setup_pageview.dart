import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_image_pick_view.dart';
import 'package:file_share_application_frontend/ui/onboarding/widgets/profile_user_info_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/Language/l10n_extensions.dart';
import '../../../global/models/app_colors.dart';
import '../../common/widget/secondary_text_button.dart';
import '../profile_setup_view_model.dart';

class ProfileSetupPageview extends StatefulWidget {
  const ProfileSetupPageview({super.key});

  @override
  State<ProfileSetupPageview> createState() => _ProfileSetupPageviewState();
}

class _ProfileSetupPageviewState extends State<ProfileSetupPageview> {
  @override
  Widget build(BuildContext context) {
    final pageController = context
        .select<ProfileSetupViewModel, PageController>(
          (viewModel) => viewModel.pageController,
        );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller: pageController,
              count: 2, // Total steps count (e.g., Step 1, Step 2, Step 3)
              effect: ExpandingDotsEffect(
                activeDotColor: context.colors.indigo, // Active pill color
                dotColor:
                    context.colors.track ??
                    Colors.grey.shade300, // Unselected dot color
                dotHeight:
                    12.0, // 👈 Increased from 8.0 to 12.0 (Adjust as desired)
                dotWidth:
                    12.0, // 👈 Increased from 8.0 to 12.0 (Adjust as desired)

                expansionFactor:
                    3.0, // 👈 Adjust this so the active pill doesn't stretch too wide now that dots are bigger
                spacing: 10.0,
              ),
            ),
            // showSkipButton
            //     ? SecondaryTextButton(
            //         text: context.strings.skip,
            //         onPressed: () {
            //           context
            //               .read<ProfileSetupViewModel>()
            //               .handleChangePageView(1);
            //         },
            //       )
            //     : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: PageView(
            controller: pageController,
            children: const [ProfileImagePickView(), ProfileUserInfoView()],
          ),
        ),
      ],
    );
  }
}
