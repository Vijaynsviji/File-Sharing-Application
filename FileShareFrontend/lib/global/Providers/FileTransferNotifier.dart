import 'package:flutter/cupertino.dart';
import 'package:file_share_application_frontend/global/models/file_model.dart';

import '../../core/enums/transferStatus.dart';
import '../models/file_progress.dart';
import '../models/peer_device.dart';
import '../models/transfer_UI.dart';

class Filetransfernotifier extends ChangeNotifier {
  // ==========================================
  // STATE VARIABLES
  // ==========================================

  /// The current peer device being interacted with (Nullable in case it's not connected yet)
  PeerDevice? _currentPeerDevice;

  /// Map of all selected files ready to be transferred: {fileId: FileModel}
  final Map<String, FileModel> _allSelectedFilesMap = {};

  /// Map of all active/past transfers: {transfer_id: TransferUi}
  final Map<String, TransferUi> _transferFilesMap = {};

  // ==========================================
  // GETTERS
  // ==========================================

  PeerDevice? get currentPeerDevice => _currentPeerDevice;

  Map<String, FileModel> get allSelectedFilesMap => _allSelectedFilesMap;

  Map<String, TransferUi> get transferFilesMap => _transferFilesMap;

  // ==========================================
  // PEER DEVICE METHODS
  // ==========================================

  void setPeerDevice(PeerDevice peerDevice) {
    _currentPeerDevice = peerDevice;
    notifyListeners();
  }

  void clearPeerDevice() {
    _currentPeerDevice = null;
    notifyListeners();
  }

  // ==========================================
  // SELECTED FILES METHODS
  // ==========================================

  void addSelectedFile(FileModel file) {
    _allSelectedFilesMap[file.fileID] = file;
    notifyListeners();
  }

  void removeSelectedFile(String fileId) {
    _allSelectedFilesMap.remove(fileId);
    notifyListeners();
  }

  void clearSelectedFiles() {
    _allSelectedFilesMap.clear();
    notifyListeners();
  }

  // ==========================================
  // TRANSFER METHODS
  // ==========================================

  /// Initializes a brand new transfer session based on the currently selected files.
  void createNewTransfer(String transferId) {
    if (_currentPeerDevice == null || _allSelectedFilesMap.isEmpty) {
      debugPrint("Cannot create transfer: Peer device or files are missing.");
      return;
    }

    // 1. Convert our selected files (FileModel) into initial FileProgress objects
    Map<String, FileProgress> initialProgressMap = {};
    _allSelectedFilesMap.forEach((fileId, fileModel) {
      initialProgressMap[fileId] = FileProgress(
        fileId: fileId,
        totalSize: fileModel.fileSize,
        transferredSize: 0, // Starts at 0
      );
    });

    // 2. Create the new TransferUi object
    final newTransfer = TransferUi(
      transferId: transferId,
      peerDevice: _currentPeerDevice!,
      files: initialProgressMap,
      status: TransferStatus.connecting, // Or pending
    );

    // 3. Add to our map and notify
    _transferFilesMap[transferId] = newTransfer;
    notifyListeners();
  }

  /// Updates the progress of a specific file inside a specific transfer session.
  /// (Called repeatedly as chunks of the file are sent/received)
  void updateTransferFileProgress(String transferId, String fileId, int bytesTransferredSoFar) {
    if (!_transferFilesMap.containsKey(transferId)) return;

    final currentTransfer = _transferFilesMap[transferId]!;

    // Uses the helper method we built in the TransferUi class earlier
    // This creates an updated copy of the TransferUi object automatically
    final updatedTransfer = currentTransfer.updateFileProgress(fileId, bytesTransferredSoFar);

    _transferFilesMap[transferId] = updatedTransfer;

    // We notify listeners so the UI progress bars can animate!
    notifyListeners();
  }

  /// Updates the overall status of a transfer (e.g., pausing, cancelling, failing)
  void updateTransferStatus(String transferId, TransferStatus newStatus) {
    if (!_transferFilesMap.containsKey(transferId)) return;

    _transferFilesMap[transferId] = _transferFilesMap[transferId]!.copyWith(
      status: newStatus,
    );
    notifyListeners();
  }

  /// Clears a specific transfer (e.g., user swipes it away from history)
  void removeTransfer(String transferId) {
    _transferFilesMap.remove(transferId);
    notifyListeners();
  }

  /// Complete reset (useful when closing the app or disconnecting)
  void resetEntireSession() {
    _currentPeerDevice = null;
    _allSelectedFilesMap.clear();
    _transferFilesMap.clear();
    notifyListeners();
  }
}