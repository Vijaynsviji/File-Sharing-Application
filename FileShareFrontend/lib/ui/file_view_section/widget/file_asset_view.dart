import 'package:file_share_application_frontend/ui/file_view_section/file_view_model.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_audio_card_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_image_card_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_video_card_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class FileAssetView extends StatelessWidget {
  final AssetEntity asset;
  const FileAssetView({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    // ONLY rebuilds if this specific asset's selected state changes
    final isSelected = context.select<FileViewModel, bool>(
      (viewModel) => viewModel.isCurrentAssetSelectedOrNot(asset),
    );

    // We still need the viewModel to call the toggle function
    final viewModel = context.read<FileViewModel>();

    if (asset.type == AssetType.audio) {
      return FileAudioCardView(
        audio: asset,
        isSelected: isSelected,
        onSelected: () => viewModel.toggleSelectImageOrVideoOrAudio(asset),
      );
    }
    if (asset.type == AssetType.video) {
      return FileVideoCardView(
        video: asset,
        isSelected: isSelected,
        onSelected: () => viewModel.toggleSelectImageOrVideoOrAudio(asset),
      );
    }
    return FileImageCardView(
      image: asset,
      isSelected: isSelected,
      onSelected: () => viewModel.toggleSelectImageOrVideoOrAudio(asset),
    );
  }
}
