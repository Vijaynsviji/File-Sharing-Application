import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/file_view_section/file_view_model.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_image_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_select_bottom_sheet_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/Utils/TextStyles.dart';
import '../../global/Providers/FileNotifiers.dart';
import '../AppScaffold.dart';

class FileView extends StatelessWidget {
  const FileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<Filenotifiers>();

    return ChangeNotifierProvider.value(
      value: FileViewModel(globalFileNotifier: viewModel),
      child: AppScaffold(
        paddingValue: EdgeInsets.only(bottom: 80),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            context.strings.selectFiles,
            style: context.styles.secondaryHeader,
          ),
        ),
        body: FileTabViwer(),
        bottomSheet: FileSelectBottomSheetView(),
      ),
    );
  }
}
