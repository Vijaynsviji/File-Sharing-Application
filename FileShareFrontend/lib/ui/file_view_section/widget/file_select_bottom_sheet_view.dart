import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/core/notifications/notification_service.dart';
import 'package:file_share_application_frontend/ui/common/widget/primary_button_custom.dart';
import 'package:file_share_application_frontend/ui/sender/sender_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../file_view_model.dart';

class FileSelectBottomSheetView extends StatelessWidget {
  const FileSelectBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFileCount = context.select<FileViewModel, int>(
      (viewModel) => viewModel.getTotalFileSelectedCount(),
    );
    final sendButtonLoading = context.select<FileViewModel, bool>(
      (viewModel) => viewModel.sendButtonLoading,
    );
    return Container(
      width: double.infinity, // Take full screen width
      height: 80, // Fixed height at the bottom
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Selected: ${selectedFileCount} files",
            style: context.styles.label,
          ),
          Skeletonizer(
            enabled: sendButtonLoading,
            child: PrimaryButtonCustom(
              onPressed: () async {
                // Action button logic
                if (selectedFileCount == 0) {
                  NotificationService.showWarningDialog(
                    "Please Select Files to Continue!",
                  );
                  return;
                }

                if (sendButtonLoading) return;
                await context.read<FileViewModel>().handleSendContinueClick();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => SenderView()),
                );
              },
              text: context.strings.send,
              buttonBorderRadius: 20,
              buttonPadding: 20,
            ),
          ),
        ],
      ),
    );
  }
}
