import 'package:file_share_application_frontend/core/Language/l10n_extensions.dart';
import 'package:file_share_application_frontend/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/Utils/TextStyles.dart';
import '../../../global/models/app_colors.dart';
import '../../common/widget/Circular_progress_indicator_custom.dart';
import '../home_model.dart';

import 'package:skeletonizer/skeletonizer.dart';

class HomeStorageView extends StatelessWidget {
  const HomeStorageView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeModel = context.select<HomeViewModel, HomeModel>(
      (viewModel) => viewModel.homeModel,
    );
    final isLoading = context.select<HomeViewModel, bool>(
      (viewModel) => viewModel.isLoading,
    );

    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: context.colors.card,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircularProgressIndicatorCustom(
              value: homeModel.usedPercentage,
              size: 80,
              strokeWidth: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    context.strings.availableCloudStorage,
                    style: context.styles.caption,
                  ),
                  Text(
                    context.strings.storageUsedOfTotal(
                      homeModel.totalUsedStorage,
                      homeModel.totalDeviceStorage,
                    ),
                    style: context.styles.listTitle,
                    softWrap: true,
                  ),
                  Text(context.strings.viewDetails, style: context.styles.link),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
