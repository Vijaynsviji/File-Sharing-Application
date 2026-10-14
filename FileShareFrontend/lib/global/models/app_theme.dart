


import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue, // Generates default Material 3 colors
    extensions:  <ThemeExtension<dynamic>>[
      AppColors.lightV2,
      AppStyles.fromColors(AppColors.lightV2),
    ],
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    extensions:  <ThemeExtension<dynamic>>[
      AppColors.darkV2,
      AppStyles.fromColors(AppColors.darkV2),
    ],
  );
}