

import 'package:file_share_application_frontend/global/models/peer_device.dart';
import '../../core/enums/transferStatus.dart';
import 'file_progress.dart';

class TransferUi {
  final String transferId;
  final PeerDevice peerDevice; // Note: Use PeerDevice if that is your class name
  final Map<String, FileProgress> files;
  final TransferStatus status;

  TransferUi({
    required this.transferId,
    required this.peerDevice,
    required this.files,
    this.status = TransferStatus.pending,
  });

  /// Dynamically calculates the overall progress of the entire transfer session (0.0 to 1.0).
  /// This automatically updates whenever a file's progress updates.
  double get overallProgress {
    if (files.isEmpty) return 0.0;

    int totalBytes = 0;
    int transferredBytes = 0;

    for (var fileProgress in files.values) {
      totalBytes += fileProgress.totalSize;
      transferredBytes += fileProgress.transferredSize;
    }

    if (totalBytes == 0) return 0.0;
    return transferredBytes / totalBytes;
  }

  /// Helper to check if all files are successfully transferred
  bool get isFullyCompleted {
    if (files.isEmpty) return false;
    return files.values.every((file) => file.isCompleted);
  }

  /// Helper to get a quick UI string (e.g., "3 / 5 files completed")
  int get completedFilesCount {
    return files.values.where((file) => file.isCompleted).length;
  }

  /// Creates a copy of the Transfer session with updated values
  TransferUi copyWith({
    String? transferId,
    PeerDevice? peerDevice,
    Map<String, FileProgress>? files,
    TransferStatus? status,
  }) {
    return TransferUi(
      transferId: transferId ?? this.transferId,
      peerDevice: peerDevice ?? this.peerDevice,
      files: files ?? this.files,
      status: status ?? this.status,
    );
  }

  /// Highly useful helper method:
  /// Updates the progress of a specific file and returns a new TransferUi instance.
  /// (Perfect for state management like Provider, Riverpod, or Bloc)
  TransferUi updateFileProgress(String fileId, int newTransferredSize) {
    // If the file doesn't exist in the map, return as is
    if (!files.containsKey(fileId)) return this;

    // Create a new map to maintain immutability
    final updatedFiles = Map<String, FileProgress>.from(files);

    // Update the specific file's progress using the copyWith from FileProgress
    updatedFiles[fileId] = updatedFiles[fileId]!.copyWith(
      transferredSize: newTransferredSize,
    );

    // If this update completes the last file, automatically mark as completed
    bool allDone = updatedFiles.values.every((f) => f.isCompleted);

    return copyWith(
      files: updatedFiles,
      status: allDone ? TransferStatus.completed : TransferStatus.transferring,
    );
  }

  @override
  String toString() {
    return 'TransferUi(transferId: $transferId, status: ${status.name}, progress: ${(overallProgress * 100).toStringAsFixed(1)}%, files: ${files.length})';
  }
}