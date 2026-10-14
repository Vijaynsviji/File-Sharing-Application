import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:flutter/material.dart';

import '../../../global/models/app_colors.dart';
import '../../settings/settings_enums.dart';

class AppBarDrawerListTile extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final String tileMainText;
  final void Function()? handleClick;
  final SettingsViewEnum tileViewType;
  const AppBarDrawerListTile({
    super.key,
    required this.iconData,
    this.iconColor,
    required this.tileMainText,
    this.handleClick,
    required this.tileViewType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 10,
          children: [
            Icon(iconData, color: iconColor ?? context.colors.ink, size: 20),
            Text(tileMainText, style: context.styles.label),
          ],
        ),
        IconButton(
          onPressed: handleClick,
          icon: Icon(
            Icons.arrow_forward_ios_sharp,
            color: iconColor ?? context.colors.ink,
            size: 15,
          ),
        ),
      ],
    );
  }
}
