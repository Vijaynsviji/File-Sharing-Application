class TransferFile {
  final String id;
  final String transferId;
  final String fileName;
  final String filePath;
  final String fileType;
  final int fileSize; // Represented as an integer (bytes)
  final String status;

  TransferFile({
    required this.id,
    required this.transferId,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.status,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'transferId': transferId,
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'fileSize': fileSize,
      'status': status,
    };
  }

  // 1. Factory to convert a Map into a TransferFile object
  factory TransferFile.fromMap(Map<String, Object?> map) {
    return TransferFile(
      id: map['id'] as String,
      transferId: map['transferId'] as String,
      fileName: map['fileName'] as String,
      filePath: map['filePath'] as String,
      fileType: map['fileType'] as String,
      fileSize: map['fileSize'] as int,
      status: map['status'] as String,
    );
  }

  // 2. Static function to convert a List<Map> to a single TransferFile object
  static TransferFile fromList(List<Map<String, Object?>> list) {
    if (list.isEmpty) {
      throw Exception('No transfer file found in the database list');
    }
    return TransferFile.fromMap(list.first);
  }

  // Implement toString to make it easier to see information about
  // each transfer file when using the print statement.
  @override
  String toString() {
    return 'TransferFile{id: $id, transferId: $transferId, fileName: $fileName, '
        'filePath: $filePath, fileType: $fileType, fileSize: $fileSize, '
        'status: $status}';
  }
}
