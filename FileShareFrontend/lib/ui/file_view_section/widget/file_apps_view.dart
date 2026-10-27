import 'package:file_share_application_frontend/ui/file_view_section/widget/file_apps_card_view.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../file_service.dart';
import '../file_view_model.dart';

class FileAppsView extends StatelessWidget {
  const FileAppsView({super.key});

  @override
  Widget build(BuildContext context) {
    final allApps = context.select<FileViewModel, List<AppInfo>>(
      (viewModel) => viewModel.installed_apps,
    );

    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = calculateImageTileCount(
      screenWidth,
      10,
      givenTileWidth: 100,
    );

    final isLoading = context.select<FileViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: isLoading ? 20 : allApps.length,
      itemBuilder: (gridContext, index) {
        if (isLoading) {
          return Skeletonizer(
            enabled: true,
            child: FileAppsCardView.skeleton(),
          );
        }

        final app = allApps[index];

        // Wrap with Builder to give Provider a clean, isolated context
        return Builder(
          builder: (itemContext) {
            // 1. Use the new itemContext for select
            final isSelected = itemContext.select<FileViewModel, bool>(
              (viewModel) => viewModel.isCurrentAppSelectedOrNot(app),
            );

            // 2. Use the new itemContext for read
            final viewModel = itemContext.read<FileViewModel>();

            return FileAppsCardView(
              appInfo: app,
              isSelected: isSelected,
              onSelected: () => viewModel.toggleSelectOrRemoveApp(app),
            );
          },
        );
      },
    );
  }
}
