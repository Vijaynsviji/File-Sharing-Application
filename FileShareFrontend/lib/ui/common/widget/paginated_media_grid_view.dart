import 'dart:ui';
import 'package:flutter/material.dart';

// Import your utility file to access calculateImageTileCount, getTotalPages, etc.
import '../../file_view_section/file_service.dart';

class PaginatedMediaGridView<T> extends StatefulWidget {
  final int totalCount;
  final int pageSize;
  final List<T> items;
  final ValueChanged<int> onPageRequested;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final int? tileWidth;

  const PaginatedMediaGridView({
    super.key,
    required this.totalCount,
    required this.pageSize,
    required this.items,
    required this.onPageRequested,
    required this.itemBuilder,
    this.tileWidth,
  });

  @override
  State<PaginatedMediaGridView<T>> createState() =>
      _PaginatedMediaGridViewState<T>();
}

class _PaginatedMediaGridViewState<T> extends State<PaginatedMediaGridView<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      double totalScrollableHeight = _scrollController.position.maxScrollExtent;
      double currentViewHeight = _scrollController.position.pixels;

      int totalPagesCount = getTotalPages(widget.totalCount, widget.pageSize);
      int currentPageValue = calculateCurrentPageView(
        totalScrollableHeight,
        totalPagesCount,
        currentViewHeight,
      );

      // Trigger the callback to fetch data
      widget.onPageRequested(currentPageValue);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = calculateImageTileCount(
      screenWidth,
      10,
      givenTileWidth: widget.tileWidth,
    );

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: RawScrollbar(
        controller: _scrollController,
        interactive: true,
        thumbVisibility: true,
        thickness: 18.0,
        minThumbLength: 48.0,
        thumbColor: Colors.black54,
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.white24, width: 1.5),
        ),
        padding: const EdgeInsets.all(0),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: widget.totalCount,
          itemBuilder: (context, index) {
            final localIndex = calculateLocalIndex(widget.pageSize, index);

            if (localIndex >= widget.items.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Return the dynamically built item based on the generic type <T>
            final item = widget.items[localIndex];
            return widget.itemBuilder(context, item);
          },
        ),
      ),
    );
  }
}
