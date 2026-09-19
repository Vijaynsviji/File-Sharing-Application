import 'dart:collection';
import 'package:file_share_application_frontend/global/models/file_model.dart';
import 'package:flutter/cupertino.dart';

import '../../core/enums/fileCategoryEnums.dart';

class Filenotifiers extends ChangeNotifier {
  final List<FileModel> _selectedFiles = [];
  final HashSet<String> _selectedFilesSet = HashSet<String>();
  final HashMap<FileCategoryEnum, List<FileModel>> _allFilesDataMap = HashMap<FileCategoryEnum, List<FileModel>>();
  bool _isLoadingFiles = false;

  // ==========================================
  // GETTERS
  // ==========================================

  List<FileModel> get selectedFiles => _selectedFiles;

  HashSet<String> get selectedFilesSet => _selectedFilesSet;

  Map<FileCategoryEnum, List<FileModel>> get allFilesDataMap => _allFilesDataMap;

  bool get isLoadingFiles => _isLoadingFiles;

  // ==========================================
  // SETTERS (Bulk Replacements)
  // ==========================================

  Future<void> loadAllFilesIfNeeded() async {
    // 1. If data is already loaded, skip fetching to make UI instant
    if (_allFilesDataMap.isNotEmpty) return;

    // 2. Start loading
    _isLoadingFiles = true;
    notifyListeners();

    try {


    } catch (e) {
      debugPrint("Error loading files: $e");
    } finally {
      // 5. Stop loading and update UI
      _isLoadingFiles = false;
      notifyListeners();
    }
  }

  /// Replaces the entire categorized files map
  set allFilesDataMap(Map<FileCategoryEnum, List<FileModel>> data) {
    _allFilesDataMap.clear();
    _allFilesDataMap.addAll(data);
    notifyListeners();
  }

  /// Replaces the selected files list and syncs the HashSet automatically
  set selectedFiles(List<FileModel> files) {
    _selectedFiles.clear();
    _selectedFilesSet.clear();

    _selectedFiles.addAll(files);
    // Assuming 'fileID' is the unique string identifier in FileModel.
    // Change it to filePath if that is what you are using in the HashSet.
    _selectedFilesSet.addAll(files.map((file) => file.fileID));

    notifyListeners();
  }

  // ==========================================
  // MUTATORS (Best practice for ChangeNotifier)
  // ==========================================

  /// Toggles a file's selection state and keeps the List and Set synced
  void toggleFileSelection(FileModel file) {
    // Again, assuming fileID is the String identifier
    if (_selectedFilesSet.contains(file.fileID)) {
      _selectedFilesSet.remove(file.fileID);
      _selectedFiles.removeWhere((element) => element.fileID == file.fileID);
    } else {
      _selectedFilesSet.add(file.fileID);
      _selectedFiles.add(file);
    }
    notifyListeners();
  }

  /// Adds a list of files to a specific category
  void addFilesToCategory(FileCategoryEnum category, List<FileModel> files) {
    if (_allFilesDataMap.containsKey(category)) {
      _allFilesDataMap[category]!.addAll(files);
    } else {
      _allFilesDataMap[category] = files;
    }
    notifyListeners();
  }

  /// Clears all current selections
  void clearSelection() {
    _selectedFiles.clear();
    _selectedFilesSet.clear();
    notifyListeners();
  }
}