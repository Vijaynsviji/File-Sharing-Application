import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../core/enums/image_source_enum.dart';

class ImageView extends StatelessWidget {
  final ImageSourceType sourceType;
  final String imagePath;

  const ImageView({
    super.key,
    required this.sourceType,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    switch (sourceType) {
      case ImageSourceType.base64:
        // Clean out any web prefixes like "data:image/png;base64," if present
        String cleanBase64 = imagePath.contains(',')
            ? imagePath.split(',').last
            : imagePath;
        cleanBase64 = cleanBase64.replaceAll(RegExp('[\\s"\']+'), '');
        return Image.memory(base64Decode(cleanBase64), fit: BoxFit.cover);

      case ImageSourceType.network:
        return Image.network(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image),
        );

      case ImageSourceType.asset:
      default:
        return Image.asset(imagePath, fit: BoxFit.cover);
    }
  }
}
