import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/ui/common/widget/huge_icon_custom.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeEmptyLatestActivity extends StatelessWidget {
  const HomeEmptyLatestActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.line),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          HugeIconCustom(icon: HugeIcons.strokeRoundedFolder01),
          Text(
            context.strings.noTransfersTitle,
            style: context.styles.listTitle,
          ),
          Text(context.strings.noTransfersBody, style: context.styles.caption),
        ],
      ),
    );
  }
}
