import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_filex/open_filex.dart';

int calculateImageTileCount(
  double width,
  int currentSpacing, {
  int? givenTileWidth = 80,
}) {
  int imageWidth = givenTileWidth ?? 80;

  // Start with the absolute maximum theoretical photos that could fit without spacing
  int totalPhotos = (width / imageWidth).toInt();
  if (totalPhotos <= 1) return 1; // Safety fallback for very narrow viewports

  int totalSpacing = currentSpacing * (totalPhotos - 1);
  int totalWidthOccupyByPhotos = totalPhotos * imageWidth;
  int totalWidthWithSpacing = totalWidthOccupyByPhotos + totalSpacing;

  while (totalWidthWithSpacing > width && totalPhotos > 1) {
    totalPhotos--;
    // FIX: Update spacing dynamically based on the new reduced item count
    totalSpacing = currentSpacing * (totalPhotos - 1);
    totalWidthOccupyByPhotos = totalPhotos * imageWidth;
    totalWidthWithSpacing = totalWidthOccupyByPhotos + totalSpacing;
  }

  return totalPhotos;
}

int getTotalPages(int totalAssetCount, int pageSize) {
  return (totalAssetCount / pageSize).floor();
}

int calculateCurrentPageView(
  double totalHeight,
  int totalPageCount,
  double currentViewPixel,
) {
  int pageRangeValue = (totalHeight / totalPageCount).floor();

  int pageValue = (currentViewPixel / pageRangeValue).floor();
  return pageValue;
}

int calculateLocalIndex(int pageSize, int currentGlobalIndex) {
  return currentGlobalIndex % pageSize;
}

Future<void> openNatively(AssetEntity asset) async {
  final File? file = await asset.file;
  if (file != null) {
    // OpenFilex handles the FileProvider and intent routing automatically
    final result = await OpenFilex.open(file.path);

    if (result.type != ResultType.done) {
      print("Could not open file: ${result.message}");
    }
  }
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

  var i = (log(bytes) / log(1024)).floor();

  // Prevent RangeError if the calculation exceeds the suffixes list length
  if (i >= suffixes.length) {
    i = suffixes.length - 1;
  }

  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

IconData getFileTypeIcon(String? extension) {
  final ext = extension?.toLowerCase();
  if (ext == 'pdf') return Icons.picture_as_pdf;
  if (['mp4', 'mkv', 'avi', 'mov'].contains(ext)) return Icons.smart_display;
  if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) return Icons.image;
  return Icons.insert_drive_file;
}

Color getIconBgColor(String? extension) {
  final ext = extension?.toLowerCase();
  if (ext == 'pdf') return const Color(0xFFEF4444);
  if (['mp4', 'mkv', 'avi', 'mov'].contains(ext))
    return const Color(0xFFA855F7);
  if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext))
    return const Color(0xFF3B82F6);
  return const Color(0xFF94A3B8);
}

String generateFileId(String path, {int? size}) {
  if (size != null && size > 0) {
    return '${path}_$size';
  }
  return path;
}
