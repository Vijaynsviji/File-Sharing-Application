import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../file_service.dart';

class FileVideoCardView extends StatelessWidget {
  final AssetEntity video;
  final bool isSelected;
  final void Function()? onSelected;

  const FileVideoCardView({
    super.key,
    required this.video,
    this.isSelected = false,
    this.onSelected,
  });

  // Helper method to format seconds into MM:SS or H:MM:SS
  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: video.thumbnailData, // Fetches video thumbnail
      builder: (context, snapshot) {
        // 1. Loading state with Skeletonizer
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            enabled: true,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const SizedBox.expand(
                child: ColoredBox(color: Colors.grey),
              ),
            ),
          );
        }

        // 2. Error handling
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Icon(Icons.videocam_off, color: Colors.grey),
          );
        }

        // 3. Render thumbnail with overlays
        return Stack(
          children: [
            // Video Thumbnail Background
            Positioned.fill(
              child: Image.memory(snapshot.data!, fit: BoxFit.cover),
            ),

            // Semi-transparent overlay to make text pop
            Positioned.fill(
              child: Container(color: Colors.black.withAlpha(30)),
            ),

            // Checkbox on Top Left
            Positioned(
              top: 0,
              left: 0,
              child: Checkbox(
                value: isSelected,
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                  width: 2,
                ), // Ensures visibility
                onChanged: (bool? value) {
                  if (onSelected != null && value != null) {
                    onSelected!();
                  }
                },
              ),
            ),

            // Open Natively Icon on Top Right
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => openNatively(video),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.open_in_full_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),

            // Video Duration Indicator
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(180),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatDuration(video.duration),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
