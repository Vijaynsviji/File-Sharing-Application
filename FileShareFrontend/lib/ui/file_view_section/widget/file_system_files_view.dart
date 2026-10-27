import 'dart:collection';

import 'package:file_picker/file_picker.dart';
import 'package:file_share_application_frontend/ui/common/widget/icon_avatar.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_system_file_tile_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/system_file_view_open_picker_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/Utils/TextStyles.dart';
import '../../../global/models/app_colors.dart';
import '../file_view_model.dart';

class FileSystemFilesView extends StatelessWidget {
  const FileSystemFilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final allSelectedFilesSet = context
        .select<FileViewModel, HashSet<PlatformFile>>(
          (viewModel) => viewModel.selectedFileSet,
        );
    final allSelectedFileList = allSelectedFilesSet.toList();
    final hideListViewBuilder = allSelectedFileList.length == 0;
    print("allSelectedFileList: " + allSelectedFileList.toString());
    if (hideListViewBuilder) {
      return SystemFileViewOpenPickerCard();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: allSelectedFileList.length,
            itemBuilder: (BuildContext context, int index) {
              final selectedFile = allSelectedFileList[index];
              return FileSystemFileTileView(
                currentFile: selectedFile,
                onRemove: () {
                  context.read<FileViewModel>().handleRemoveFileFromSelected(
                    selectedFile,
                  );
                },
              );
            },
          ),
        ),
        SystemFileViewOpenPickerCard(),
      ],
    );
  }
}
