import 'dart:collection';

import 'package:file_share_application_frontend/global/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:file_picker/file_picker.dart';

import '../../core/Utils/device_settings_util.dart';
import '../../core/notifications/notification_service.dart';
import '../../global/Providers/FileNotifiers.dart';
import 'file_service.dart';

class FileViewModel extends ChangeNotifier {
  Filenotifiers globalFileNotifier;
  AssetPathEntity? photosPath = null;
  List<AssetEntity> photos = [];
  Map<int, List<AssetEntity>> pageAssetMap = Map();
  Set<String> allSelectedFilesSet = Set();
  Map<String, AssetEntity> selectedAssetsEntity = Map();

  List<AppInfo> installed_apps = [];
  bool isAlreadyAppsFetched = false;
  Map<String, AppInfo> selectedAppsEntity = Map();
  // Set<>

  HashSet<PlatformFile> selectedFileSet = HashSet();

  int totalPhotosCount = 0;
  int pageSize = 80;

  AssetPathEntity? audioPath = null;
  List<AssetEntity> audioFiles = [];
  Map<int, List<AssetEntity>> audioPageAssetsMap = Map();
  int totalAudioCount = 0;
  int audioPageSize = 80;

  bool isLoading = false;
  bool sendButtonLoading = false;

  FileViewModel({required this.globalFileNotifier}) {
    initialLoad();
  }

  Future<void> initialLoad() async {
    bool hasPermission = await DeviceSettingsUtil.ensureReady([
      DeviceHardware.photos,
      DeviceHardware.videos,
      DeviceHardware.manageExternalStorage,
    ]);
    if (!hasPermission) return;

    totalPhotosCount = await PhotoManager.getAssetCount(
      // Fetches only the consolidated virtual album
      type: RequestType.all,
    );
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true, // Fetches only the consolidated virtual album
      type: RequestType.all,
    );
    print("PhotosCount: " + totalPhotosCount.toString());
    if (paths.length > 0) {
      final path = paths[0];
      photosPath = path;
      photos = await path.getAssetListPaged(page: 0, size: pageSize);
      pageAssetMap[0] = photos;
    }
    notifyListeners();
  }

  Future<void> getGivenPagePhotos(int pageValue) async {
    try {
      if (photosPath == null) return;

      if (pageAssetMap.containsKey(pageValue)) {
        photos = pageAssetMap[pageValue] ?? [];
        return;
      }

      photos = await photosPath!.getAssetListPaged(
        page: pageValue,
        size: pageSize,
      );
      pageAssetMap[pageValue] = photos;
    } catch (e) {
      NotificationService.showErrorDialog('Not able to Load Photos');
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleSelectImageOrVideoOrAudio(AssetEntity asset) async {
    final assetPath = asset.id;
    final uniqueFileId = generateFileId(assetPath!);
    if (allSelectedFilesSet.contains(uniqueFileId)) {
      // Create new references with the item removed
      allSelectedFilesSet = {...allSelectedFilesSet}..remove(uniqueFileId);
      selectedAssetsEntity = {...selectedAssetsEntity}..remove(uniqueFileId);
    } else {
      // Create new references with the new item added
      allSelectedFilesSet = {...allSelectedFilesSet, uniqueFileId};
      selectedAssetsEntity = {...selectedAssetsEntity, uniqueFileId: asset};
    }
    notifyListeners();
    // final fileModel = FileModel(
    //   fileID: uniqueFileId,
    //   fileName: asset.name,
    //   filePath: assetPath,
    //   fileType: asset.type.toString(),
    //   fileSize: 0,
    //   fileMetadata: {},
    // );

    // globalFileNotifier.toggleFileSelection(fileModel);
  }

  bool isCurrentAssetSelectedOrNot(AssetEntity asset) {
    final assetPath = asset.id;
    final uniqueFileId = generateFileId(assetPath!);
    return selectedAssetsEntity.containsKey(uniqueFileId);
  }

  int getTotalFileSelectedCount() {
    return allSelectedFilesSet.length + selectedFileSet.length;
  }

  Future<void> fetchApps() async {
    try {
      if (isAlreadyAppsFetched) return;
      isLoading = true;
      notifyListeners();
      installed_apps = await InstalledApps.getInstalledApps(
        excludeSystemApps: true, // Exclude pre-installed system apps
        excludeNonLaunchableApps:
            true, // Exclude apps without a launcher intent
        withIcon: true, // Include app icons (returns Uint8List?)
      );
      isAlreadyAppsFetched = true;
      isLoading = false;
    } catch (e) {
      isLoading = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleSelectOrRemoveApp(AppInfo app) async {
    final uniqueFileId = app.packageName;
    if (allSelectedFilesSet.contains(uniqueFileId)) {
      allSelectedFilesSet = {...allSelectedFilesSet}..remove(uniqueFileId);
      selectedAppsEntity = {...selectedAppsEntity}..remove(uniqueFileId);
    } else {
      allSelectedFilesSet = {...allSelectedFilesSet, uniqueFileId};
      selectedAppsEntity = {...selectedAppsEntity, uniqueFileId: app};
    }
    notifyListeners();
  }

  bool isCurrentAppSelectedOrNot(AppInfo app) {
    final uniqueFileId = app.packageName;

    return selectedAppsEntity.containsKey(uniqueFileId);
  }

  Future<void> openFilePicker() async {
    try {
      final List<PlatformFile> files = await FilePicker.pickFiles(
        type: FileType.any,
      );

      if (files.isNotEmpty) {
        // Create a copy, add the files, and reassign it to force a new reference
        final updatedSet = HashSet<PlatformFile>.from(selectedFileSet);
        for (PlatformFile file in files) {
          updatedSet.add(file);
        }

        selectedFileSet =
            updatedSet; // 💡 Key change: new reference triggers updates
      } else {
        print("User cancelled the picker.");
      }
    } catch (e) {
      print("Error picking files: $e");
    } finally {
      notifyListeners(); // Now this will successfully trigger a re-render
    }
  }

  void handleRemoveFileFromSelected(PlatformFile file) async {
    final updatedSet = HashSet<PlatformFile>.from(selectedFileSet);
    updatedSet.remove(file);
    selectedFileSet = updatedSet;
    notifyListeners();
  }

  Future<void> loadAudioFiles() async {
    bool hasPermission = await DeviceSettingsUtil.ensureReady([
      DeviceHardware.audio,
      DeviceHardware.manageExternalStorage,
    ]);
    if (!hasPermission) return;

    // 1. Request permission
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) return;

    totalAudioCount = await PhotoManager.getAssetCount(
      // Fetches only the consolidated virtual album
      type: RequestType.audio,
    );
    // 2. Get the audio path (consolidated virtual album)
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
      onlyAll: true,
      type: RequestType.audio, // <-- Set to audio
    );

    if (paths.isNotEmpty) {
      audioPath = paths[0];

      // 3. Fetch the first page of audio files
      audioFiles = await audioPath!.getAssetListPaged(
        page: 0,
        size: audioPageSize,
      );
      audioPageAssetsMap[0] = audioFiles;
      // for (var audio in audioFiles) {
      //   print("Audio Title: ${audio.title}");
      //   print("Audio Duration: ${audio.duration}"); // Duration in seconds
      // }
    }
    notifyListeners();
  }

  Future<void> getGivenPageAudioFiles(int pageValue) async {
    try {
      if (audioPath == null) return;

      if (audioPageAssetsMap.containsKey(pageValue)) {
        audioFiles = audioPageAssetsMap[pageValue] ?? [];
        return;
      }

      audioFiles = await audioPath!.getAssetListPaged(
        page: pageValue,
        size: pageSize,
      );
      audioPageAssetsMap[pageValue] = photos;
    } catch (e) {
      NotificationService.showErrorDialog('Not able to Load Photos');
    } finally {
      notifyListeners();
    }
  }

  Future<void> handleSendContinueClick() async {
    try {
      sendButtonLoading = true;
      notifyListeners();
      List<FileModel> allSelectedFiles = [];

      if (selectedAssetsEntity.length > 0) {
        for (AssetEntity asset in selectedAssetsEntity.values) {
          final currentFile = FileModel(
            fileID: asset.id,
            fileName: await asset.titleAsync,
            filePath: asset.relativePath ?? '',
            fileType: asset.type.toString(),
            fileSize: await asset.fileSize,
            fileMetadata: {},
          );

          allSelectedFiles.add(currentFile);
        }
      }

      if (selectedAppsEntity.length > 0) {
        for (AppInfo asset in selectedAppsEntity.values) {
          final currentFile = FileModel(
            fileID: asset.packageName,
            fileName: await asset.name,
            filePath: '',
            fileType: 'apk',
            fileSize: 0,
            fileMetadata: {},
          );

          allSelectedFiles.add(currentFile);
        }
      }

      if (selectedFileSet.length > 0) {
        for (PlatformFile asset in selectedFileSet) {
          final currentFile = FileModel(
            fileID: asset.path ?? "",
            fileName: asset.name,
            filePath: asset.path ?? '',
            fileType: asset.extension.toString(),
            fileSize: await asset.lengthSync() ?? 0,
            fileMetadata: {},
          );

          allSelectedFiles.add(currentFile);
        }
      }

      globalFileNotifier.selectedFiles = allSelectedFiles;

      sendButtonLoading = false;
    } catch (e) {
      sendButtonLoading = false;
      NotificationService.showErrorDialog("Not able to Send Files!");
    } finally {
      notifyListeners();
    }
  }
}
