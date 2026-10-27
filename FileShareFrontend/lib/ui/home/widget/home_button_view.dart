import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/home/widget/home_button_card.dart';
import 'package:file_share_application_frontend/ui/receiver/receiver_view.dart';
import 'package:file_share_application_frontend/ui/wifi_direct_groups/wifi_direct_group_view.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/Language/l10n_extensions.dart';
import '../../../global/models/app_colors.dart';
import '../../file_view_section/file_view.dart';

class HomeButtonView extends StatelessWidget {
  const HomeButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeButtonCard(
              hugeIconValue: HugeIcons.strokeRoundedTelegram,
              buttonText: context.strings.send,
              handleButtonClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => FileView()),
                );
              },
              cardBackgroundColor: context.colors.indigo,
              borderRadiusValue: 20,
            ),
            HomeButtonCard(
              hugeIconValue: HugeIcons.strokeRoundedFileDownload,
              buttonText: context.strings.receive,
              handleButtonClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => ReceiverView()),
                );
              },
              cardBackgroundColor: context.colors.blue,
              borderRadiusValue: 20,
            ),
          ],
        ),
        PrimaryButtonCustom(
          // text: context.strings.send,
          text: context.strings.webShare,
          onPressed: () {},
          BackgroundColor: context.colors.card,
          textColor: context.colors.ink,
        ),
      ],
    );
  }
}
