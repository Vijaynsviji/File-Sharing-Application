import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/core/enums/languageEnums.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/ui/settings/widget/settings_language_list_tile_view.dart';
import 'package:flutter/material.dart';

class SettingsLanguageView extends StatelessWidget {
  const SettingsLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final languageList = LanguageEnums.values;
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Aligns title text to the left
      spacing: 20,
      children: [
        // 2. 🟢 Add your Title Text here safely
        Text(context.strings.language, style: context.styles.label),
        Expanded(
          child: ListView.separated(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: languageList.length, // Total number of items in the list
            itemBuilder: (context, index) {
              final language = languageList[index];
              return SettingsLanguageListTileView(language: language);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1, // The absolute height space the divider allocates
                thickness: 1, // The visual thickness of the line line itself
                color: context.colors.line, // Theme-aware adaptive color
                indent: 16, // Optional: Pushes the line away from the left edge
                endIndent:
                    16, // Optional: Pushes the line away from the right edge
              );
            },
          ),
        ),
      ],
    );
  }
}
