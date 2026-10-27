import 'package:file_share_application_frontend/global/models/app_colors.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/audio_file_view.dart';
import 'package:file_share_application_frontend/ui/file_view_section/widget/file_apps_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/Language/l10n_extensions.dart';
import '../file_view_model.dart';
import 'file_image_view.dart';
import 'file_system_files_view.dart';

class FileTabViwer extends StatefulWidget {
  const FileTabViwer({super.key});

  @override
  State<FileTabViwer> createState() => _FileTabViwerState();
}

class _FileTabViwerState extends State<FileTabViwer>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the local TabController using this class's vsync ticker
    _tabController = TabController(length: 4, vsync: this);

    // 2. Attach your custom tab-change execution function listener
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    // This check filters out duplicate animation ticks and triggers exactly ONCE per swap
    // if (_tabController.indexIsChanging) {
    //   print("Active view changed to index: ${_tabController.index}");
    if (_tabController.index == 3) {
      context.read<FileViewModel>().fetchApps();
    }
    if (_tabController.index == 2) {}
    if (_tabController.index == 1) {
      context.read<FileViewModel>().loadAudioFiles();
    }
    // Execute your specific functions here based on the selected tab index
    // }
  }

  @override
  void dispose() {
    // 3. Clean up the controller and listener memory allocations on destruction
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBar(
          controller: _tabController, // <-- Bound to local state controller
          isScrollable: true,
          padding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          indicatorColor: context.colors.indigo,
          labelColor: context.colors.indigo,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: context.strings.imagesOrVideos),
            Tab(text: context.strings.audio),
            Tab(text: context.strings.filesLabel),
            Tab(text: context.strings.apps),
          ],
        ),

        Expanded(
          child: TabBarView(
            controller:
                _tabController, // <-- Bound to exact same local state controller
            children: [
              FileImageView(),
              // const Center(child: Text('Audio Files View')),
              AudioFileView(),
              // const Center(child: Text('Documents & Files View')),
              FileSystemFilesView(),
              // const Center(child: Text('Installed Apps View')),
              FileAppsView(),
            ],
          ),
        ),
      ],
    );
  }
}
