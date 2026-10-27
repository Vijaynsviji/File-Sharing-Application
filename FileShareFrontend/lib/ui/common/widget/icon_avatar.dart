import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../global/models/app_colors.dart';

class IconAvatar extends StatelessWidget {
  final IconData icon;
  final double height;
  final double width;
  final double borderWidth;
  final bool isAvatarSelected;
  final bool isLoading;

  const IconAvatar({
    super.key,
    required this.icon,
    required this.isAvatarSelected,
    this.height = 50.0,
    this.width = 50.0,
    this.borderWidth = 3.0,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Extract the first letter, convert to uppercase. Fallback to '?' if string is empty.
    // final String initial = name.trim().isNotEmpty
    //     ? name.trim()[0].toUpperCase()
    //     : '?';

    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: Skeleton.replace(
        replacement: Bone.circle(size: width),
        child: Container(
          width: width,
          height: height,
          padding: isAvatarSelected
              ? EdgeInsets.all(borderWidth)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            gradient: isAvatarSelected ? context.colors.grad : null,
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: height / 2),
          ),
        ),
      ),
    );
  }
}
