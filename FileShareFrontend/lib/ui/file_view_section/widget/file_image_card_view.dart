import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../file_service.dart';

class FileImageCardView extends StatelessWidget {
  final AssetEntity image;
  final bool isSelected;
  final void Function()? onSelected;

  const FileImageCardView({
    super.key,
    required this.image,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: image.thumbnailData,
      builder: (context, snapshot) {
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

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          );
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Image.memory(snapshot.data!, fit: BoxFit.cover),
            ),

            // Checkbox on Top Left
            Positioned(
              top: 0,
              left: 0,
              child: Checkbox(
                materialTapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Removes default padding
                visualDensity:
                    VisualDensity.compact, // Makes it even tighter to the edge
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

            // Open Natively Icon on Top Right
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => openNatively(image),
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
          ],
        );
      },
    );
  }
}
