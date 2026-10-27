import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/Utils/TextStyles.dart';
import '../../../global/models/app_colors.dart';
import '../../common/widget/icon_avatar.dart';
import '../../common/widget/primary_button_custom.dart';
import '../file_view_model.dart';

class SystemFileViewOpenPickerCard extends StatelessWidget {
  const SystemFileViewOpenPickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.line),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          IconAvatar(
            icon: Icons.create_new_folder_outlined,
            isAvatarSelected: false,
          ),
          Center(
            child: Text("Add More Files", style: context.styles.listTitle),
          ),
          Center(
            child: Text(
              "Open the file picker to select more files from your device.",
              style: context.styles.caption,
              softWrap: true,
            ),
          ),
          PrimaryButtonCustom(
            text: "Open File Picker",
            onPressed: () {
              context.read<FileViewModel>().openFilePicker();
            },
          ),
        ],
      ),
    );
  }
}
