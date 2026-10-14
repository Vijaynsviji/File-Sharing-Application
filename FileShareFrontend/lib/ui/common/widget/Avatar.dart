import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../global/models/app_colors.dart';
import 'Image_view.dart';

class Avatar extends StatelessWidget {
  final ProfileImageModel profileImageModel;
  final double height;
  final double width;
  final double borderWidth; // Controls the border thickness when selected
  final bool isAvatarSelected;
  final bool isLoading;

  const Avatar({
    super.key,
    required this.profileImageModel,
    required this.isAvatarSelected,
    this.height = 50.0,
    this.width = 50.0,
    this.borderWidth = 3.0, // Thickness of your gradient border
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return Bone.circle(size: width);
    // }

    return Skeletonizer(
      enabled: isLoading,
      ignoreContainers: true,
      child: Skeleton.replace(
        replacement: Bone.circle(size: width),
        child: Container(
          width: width,
          height: height,
          // 🟢 Apply padding only if selected, so the image stays full size when unselected
          padding: isAvatarSelected
              ? EdgeInsets.all(borderWidth)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            // 1. Apply the LinearGradient directly to the outer container when selected
            gradient: isAvatarSelected ? context.colors.grad : null,
            shape: BoxShape.circle, // 🟢 Always a perfect circle now
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white, // Fallback background color behind the image
              shape: BoxShape
                  .circle, // 🟢 Always a perfect circle matching the parent
            ),
            clipBehavior:
                Clip.antiAlias, // Clips the image to a perfect circle shape
            child: ImageView(
              sourceType: profileImageModel.sourceType,
              imagePath: profileImageModel.path,
            ),
          ),
        ),
      ),
    );
  }
}
