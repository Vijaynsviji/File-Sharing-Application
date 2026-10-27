import 'package:file_picker/file_picker.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:flutter/material.dart';

import '../file_service.dart';

class FileSystemFileTileView extends StatelessWidget {
  final PlatformFile currentFile;
  final VoidCallback? onRemove;

  const FileSystemFileTileView({
    super.key,
    required this.currentFile,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final formattedSize = formatBytes(currentFile.lengthSync() ?? 0, 1);
    final fileIcon = getFileTypeIcon(currentFile.extension);
    final iconBgColor = getIconBgColor(currentFile.extension);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(fileIcon, size: 24),
      ),
      title: Text(
        currentFile.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.styles.listTitle,
      ),
      subtitle: Text(formattedSize, style: context.styles.subtitle),
      trailing: onRemove != null
          ? IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: onRemove,
              splashRadius: 20,
            )
          : null,
    );
  }
}
