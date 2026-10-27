import 'package:file_share_application_frontend/ui/common/widget/paginated_media_grid_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/file_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../file_view_model.dart';
import 'file_asset_view.dart';

class FileImageView extends StatelessWidget {
  const FileImageView({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCount = context.select<FileViewModel, int>(
      (viewModel) => viewModel.totalPhotosCount,
    );
    final allImages = context.select<FileViewModel, List<AssetEntity>>(
      (viewModel) => viewModel.photos,
    );

    final pageSize = context.select<FileViewModel, int>(
      (viewModel) => viewModel.pageSize,
    );

    final viewModel = context.read<FileViewModel>();

    return PaginatedMediaGridView(
      totalCount: totalCount,
      pageSize: pageSize,
      items: allImages,
      onPageRequested: (pageValue) {
        viewModel.getGivenPagePhotos(pageValue);
      },
      itemBuilder: (context, asset) {
        return FileAssetView(asset: asset);
      },
    );
  }
}

// import 'dart:ui';
//
// import 'package:file_share_application_frontend/ui/file_view_section/file_view_model.dart';
// import 'package:file_share_application_frontend/ui/file_view_section/widget/file_asset_view.dart';
// import 'package:file_share_application_frontend/ui/file_view_section/widget/file_image_card_view.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:provider/provider.dart';
//
// import '../file_service.dart';
//
// class FileImageView extends StatefulWidget {
//   const FileImageView({super.key});
//
//   @override
//   State<FileImageView> createState() => _FileImageViewState();
// }
//
// class _FileImageViewState extends State<FileImageView> {
//   late final ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_onScroll);
//   }
//
//   void _onScroll() {
//     if (_scrollController.hasClients) {
//       double totalScrollableHeight = _scrollController.position.maxScrollExtent;
//       double currentViewHeight = _scrollController.position.pixels;
//
//       final viewModel = context.read<FileViewModel>();
//
//       int totalAssetsCount = viewModel.totalPhotosCount;
//       int pageSize = viewModel.pageSize;
//
//       int totalPagesCount = getTotalPages(totalAssetsCount, pageSize);
//       int currentPageValue = calculateCurrentPageView(
//         totalScrollableHeight,
//         totalPagesCount,
//         currentViewHeight,
//       );
//       print("Current View Page Value: " + currentPageValue.toString());
//       viewModel.getGivenPagePhotos(currentPageValue);
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final totalCount = context.select<FileViewModel, int>(
//       (viewModel) => viewModel.totalPhotosCount,
//     );
//     final allImages = context.select<FileViewModel, List<AssetEntity>>(
//       (viewModel) => viewModel.photos,
//     );
//
//     final double screenWidth = MediaQuery.of(context).size.width;
//     int crossAxisCount = calculateImageTileCount(screenWidth, 10);
//
//     // Enables scrollbar dragging with computer mice on emulators/desktops
//     return ScrollConfiguration(
//       behavior: ScrollConfiguration.of(context).copyWith(
//         dragDevices: {
//           PointerDeviceKind.touch,
//           PointerDeviceKind.mouse,
//           PointerDeviceKind.trackpad,
//         },
//       ),
//       // 1. Swap Scrollbar out for RawScrollbar
//       child: RawScrollbar(
//         controller: _scrollController,
//         interactive: true, // Makes the bubble touch-draggable
//         thumbVisibility: true, // Keeps the handle visible during pagination
//         // 2. Custom Styling to replicate a Gallery handle
//         thickness: 18.0, // Make it significantly wider so it's easy to grab
//         minThumbLength:
//             48.0, // Ensures the handle doesn't shrink into a tiny speck
//         thumbColor: Colors.black54, // Dark translucent background style
//         // 3. Define the specific Gallery Shape
//         shape: const StadiumBorder(
//           side: BorderSide(
//             color: Colors.white24, // Subtle white border line around the thumb
//             width: 1.5,
//           ),
//         ),
//
//         // Optional Padding: Offsets the thumb bubble slightly away from the extreme screen edge
//         padding: const EdgeInsets.all(0),
//
//         child: GridView.builder(
//           padding: EdgeInsets.all(10),
//           controller: _scrollController,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemCount: totalCount,
//           itemBuilder: (context, index) {
//             final localIndex = calculateLocalIndex(80, index);
//
//             if (localIndex >= allImages.length) {
//               return const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//
//             final item = allImages[localIndex];
//             return FileAssetView(asset: item);
//           },
//         ),
//       ),
//     );
//   }
// }
