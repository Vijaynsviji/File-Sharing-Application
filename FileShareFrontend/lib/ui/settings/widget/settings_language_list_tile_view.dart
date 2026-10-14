import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/core/enums/languageEnums.dart';
import 'package:file_share_application_frontend/ui/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsLanguageListTileView extends StatelessWidget {
  final LanguageEnums language;
  const SettingsLanguageListTileView({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.select<SettingsViewModel, LanguageEnums>(
      (viewModel) => viewModel!.settingsModel!.languageEnums,
    );
    print("Current Lanugage");
    print(currentLanguage);
    return ListTile(
      // style: ListTileStyle.list,
      // shape: RoundedRectangleBorder(),
      leading: Text(
        language.code.toUpperCase(),
        style: context.styles.listTitle,
      ),
      title: Text(language.englishName, style: context.styles.listTitle),
      subtitle: Text(language.nativeName, style: context.styles.caption),
      selected: currentLanguage == language,
      onTap: () {
        context.read<SettingsViewModel>().handleChangeLanugae(language);
      },
      trailing: currentLanguage == language
          ? Icon(
              Icons.check_circle,
              color: Theme.of(
                context,
              ).colorScheme.primary, // Or use context.colors.primary if defined
            )
          : null,
    );
  }
}
