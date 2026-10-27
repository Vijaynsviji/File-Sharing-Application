import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../global/models/app_colors.dart';
import '../file_service.dart';

class FileAudioCardView extends StatelessWidget {
  final AssetEntity audio;
  final bool isSelected;
  final void Function()? onSelected;

  const FileAudioCardView({
    super.key,
    required this.audio,
    this.isSelected = false,
    this.onSelected,
  });

  // Helper method to convert seconds into a mm:ss format
  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = (duration.inSeconds % 60).toString().padLeft(
      2,
      '0',
    );
    return '$minutes:$remainingSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.grey.shade100,
      child: Stack(
        children: [
          // Background: Default music icon since thumbnails aren't supported
          Positioned.fill(
            child: Center(
              child: Icon(
                Icons.audiotrack,
                size: 48,
                color: context.colors.scrim,
              ),
            ),
          ),

          // Bottom Gradient to ensure text readability
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                ),
              ),
            ),
          ),

          // Checkbox on Top Left
          Positioned(
            top: 0,
            left: 0,
            child: Checkbox(
              value: isSelected,
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2),
              onChanged: (bool? value) {
                if (onSelected != null && value != null) {
                  onSelected!();
                }
              },
            ),
          ),

          // Audio Title & Duration Text
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  audio.title ?? 'Unknown Audio',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDuration(audio.duration),
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),

          // Play / Open Natively Button
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => openNatively(audio),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
