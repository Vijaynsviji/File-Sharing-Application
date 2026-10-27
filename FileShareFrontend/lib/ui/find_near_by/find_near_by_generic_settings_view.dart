import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/ui/common/widget/icon_avatar.dart';
import 'package:file_share_application_frontend/ui/common/widget/outlined_button_custom.dart';
import 'package:file_share_application_frontend/ui/find_near_by/permission_action_item_model.dart';
import 'package:flutter/material.dart';

class GenericPermissionSettingsView extends StatelessWidget {
  final String title;
  final List<PermissionActionItem> settingsList;

  const GenericPermissionSettingsView({
    super.key,
    required this.title,
    required this.settingsList,
  });

  @override
  Widget build(BuildContext context) {
    // Filter to only show items that are NOT granted yet
    final missingPermissions = settingsList
        .where((item) => !item.isGranted)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        Text(title, style: context.styles.label),
        Expanded(
          child: ListView.builder(
            itemCount: missingPermissions.length,
            itemBuilder: (context, index) {
              final item = missingPermissions[index];

              return ListTile(
                leading: IconAvatar(
                  icon: item.icon,
                  isAvatarSelected: false,
                  height: 30,
                  width: 30,
                ),
                title: Text(item.text, style: context.styles.listTitle),
                trailing: OutlinedButtonCustom(
                  text: context
                      .strings
                      .join, // Or pass a custom button string if needed
                  onPressed: item.onPressed,
                  buttonBorderRadius: 30,
                  buttonPadding: 0,
                  height: 40,
                  textSize: 10,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
