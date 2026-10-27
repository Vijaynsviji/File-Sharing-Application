import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_category.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/platform_type.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../file_view_model.dart';

class FileAppsCardView extends StatelessWidget {
  final AppInfo appInfo;
  final bool isSelected;
  final void Function()? onSelected;

  const FileAppsCardView({
    super.key,
    required this.appInfo,
    required this.isSelected,
    this.onSelected,
  });

  factory FileAppsCardView.skeleton() {
    return FileAppsCardView(
      appInfo: AppInfo(
        name: 'Loading Application', // Gives skeleton standard text width
        packageName: 'com.loading.app',
        versionName: '...',
        versionCode: 0,
        icon: null,
        platformType: PlatformType.flutter, // Safe fallback for enums/objects
        installedTimestamp: 0, // Typically an integer timestamp
        isSystemApp: false,
        isLaunchableApp: false,
        category: AppCategory.game,
      ),
      isSelected: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.colors.indigo;
    final isLoading = context.select<FileViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );

    return InkWell(
      onTap: () {
        if (onSelected != null) {
          onSelected!();
        }
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. App Icon Box with an integrated Overlaid Checkbox
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 64, // <-- FIX: Explicit width
                  height: 64, // <-- FIX: Explicit height
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(
                      0.08,
                    ), // Subtle background box
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: appInfo.icon != null
                      ? Image.memory(
                          appInfo.icon!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.android,
                                size: 36,
                                color: Colors.grey,
                              ),
                        )
                      : const Icon(Icons.android, size: 36, color: Colors.grey),
                ),
                // Corner Checkbox implementation
                Positioned(
                  top: 0,
                  left: 0,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Removes default padding
                    visualDensity: VisualDensity
                        .compact, // Makes it even tighter to the edge
                    value: isSelected,
                    activeColor: Theme.of(context).primaryColor,
                    checkColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ), // Ensures visibility over images
                    onChanged: (bool? value) {
                      if (onSelected != null && value != null) {
                        onSelected!();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // 2. App Name Text Row
            Text(
              appInfo.name ?? 'Unknown',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(height: 2.0),

            // 3. App Storage Size Text Row
            Text(
              appInfo.category.toString() ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
