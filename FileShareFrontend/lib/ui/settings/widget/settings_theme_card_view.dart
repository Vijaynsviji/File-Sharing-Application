import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/core/Utils/TextStyles.dart';
import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings_view_model.dart';

class SettingsThemeCardView extends StatelessWidget {
  final ThemeMode themeMode;

  const SettingsThemeCardView({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.select<SettingsViewModel, ThemeMode>(
      (viewModel) => viewModel!.settingsModel!.themeMode,
    );
    bool isSelected = currentTheme == themeMode;

    // 🟢 2. Outer wrapper Container that paints the context.colors.grad border ring smoothly
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<SettingsViewModel>().handleChangeTheme(themeMode);
        },
        child: Container(
          padding: isSelected
              ? const EdgeInsets.all(2.0)
              : EdgeInsets.zero, // Thickness of gradient border line
          decoration: BoxDecoration(
            // Applies the gradient border ONLY when active, else stays completely transparent
            gradient: isSelected ? context.colors.grad : null,
            borderRadius: BorderRadius.circular(
              12,
            ), // Slightly larger radius to account for spacing layers
          ),
          child: _buildInnerCardContent(context),
        ),
      ),
    );
  }

  // 🟢 Helper building block to render the standard interior layout assets cleanly
  Widget _buildInnerCardContent(BuildContext context) {
    if (themeMode == ThemeMode.light || themeMode == ThemeMode.dark) {
      final isLightMode = themeMode == ThemeMode.light;
      final modeString = isLightMode
          ? context.strings.themeLight
          : context.strings.themeDark;

      return Container(
        height: 140,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colors.cardAlt,
          borderRadius: BorderRadius.circular(
            10,
          ), // Snugly nests inside the outer border line container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isLightMode ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _buildMockUiLayout(context),
              ),
            ),
            Text(modeString, style: context.styles.label),
          ],
        ),
      );
    } else {
      // ONE container layout structure with a sharp half-and-half gradient split for System variant
      return Container(
        height: 140,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.colors.cardAlt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Colors.white, Colors.black],
                    stops: [0.5, 0.5],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: _buildMockUiLayout(context),
              ),
            ),
            Text(context.strings.themeSystem, style: context.styles.label),
          ],
        ),
      );
    }
  }

  // Helper widget to paint the mock preview lines inside the cards
  Widget _buildMockUiLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 6,
      children: [
        Container(
          width: 55,
          height: 7,
          decoration: BoxDecoration(
            gradient: context.colors.grad,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: context.colors.track,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Container(
          width: 25,
          height: 5,
          decoration: BoxDecoration(
            color: context.colors.track,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}
