import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../common/widget/paginated_media_grid_view.dart';
import '../file_view_model.dart';
import 'file_asset_view.dart';

class AudioFileView extends StatelessWidget {
  const AudioFileView({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCount = context.select<FileViewModel, int>(
      (viewModel) => viewModel.totalAudioCount,
    );
    final allImages = context.select<FileViewModel, List<AssetEntity>>(
      (viewModel) => viewModel.audioFiles,
    );

    final pageSize = context.select<FileViewModel, int>(
      (viewModel) => viewModel.audioPageSize,
    );

    final viewModel = context.read<FileViewModel>();

    return PaginatedMediaGridView(
      totalCount: totalCount,
      pageSize: pageSize,
      items: allImages,
      onPageRequested: (pageValue) {
        viewModel.getGivenPageAudioFiles(pageValue);
      },
      itemBuilder: (context, asset) {
        return FileAssetView(asset: asset);
      },
      tileWidth: 120,
    );
  }
}
