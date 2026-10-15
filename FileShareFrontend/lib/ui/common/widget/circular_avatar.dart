import 'dart:io';

import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/ui/common/widget/Image_view.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final ProfileImageModel imageModel;
  final double width;
  final double borderWidth;
  final double imagePadding;

  const CircularAvatar({
    super.key,
    this.width =
        120, // 🟢 Set a default larger width matching your profile setup size
    required this.imageModel,
    this.borderWidth = 2.0, // 🟢 Thin border ring matching your image layout
    this.imagePadding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      padding: EdgeInsets.all(borderWidth),
      // 🟢 Dictates the gradient ring thickness
      decoration: BoxDecoration(
        gradient: context.colors.grad,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: EdgeInsets.all(imagePadding),
        // 🟢 Adjusts the white/transparent spacing area around the emoji face
        decoration: BoxDecoration(
          color: context.colors.card,
          // 🟢 Soft solid background container fill color inside the ring
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: ImageView(
            sourceType: imageModel.sourceType,
            imagePath: imageModel.path,
          ),
        ),
      ),
    );
  }
}
