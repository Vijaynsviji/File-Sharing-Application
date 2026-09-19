

class FileProgress {
  final String fileId;
  final int totalSize;
  final int transferredSize;

  FileProgress({
    required this.fileId,
    required this.totalSize,
    this.transferredSize = 0, // Defaults to 0 when transfer just starts
  });

  double get progressPercentage {
    if (totalSize == 0) return 0.0;
    return transferredSize / totalSize;
  }

  bool get isCompleted {
    return totalSize > 0 && transferredSize >= totalSize;
  }

  FileProgress copyWith({
    String? fileId,
    int? totalSize,
    int? transferredSize,
  }) {
    return FileProgress(
      fileId: fileId ?? this.fileId,
      totalSize: totalSize ?? this.totalSize,
      transferredSize: transferredSize ?? this.transferredSize,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'fileId': fileId,
      'totalSize': totalSize,
      'transferredSize': transferredSize,
    };
  }

  /// Creates a progress instance from a Map
  factory FileProgress.fromMap(Map<String, dynamic> map) {
    return FileProgress(
      fileId: map['fileId'] as String,
      totalSize: map['totalSize'] as int,
      transferredSize: map['transferredSize'] as int? ?? 0,
    );
  }

  @override
  String toString() {
    return 'FileProgress(fileId: $fileId, transferred: $transferredSize / $totalSize bytes)';
  }
}