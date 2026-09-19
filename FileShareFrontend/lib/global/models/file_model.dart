



class FileModel {
  final String fileID;
  final String fileName;
  final String filePath;
  final String fileType;
  final int fileSize; // Best practice is to store size in bytes as an int
  final Map<String, dynamic> fileMetadata;

  FileModel({
    required this.fileID,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.fileMetadata,
  });

  /// Creates a new [FileModel] with updated properties
  FileModel copyWith({
    String? fileID,
    String? fileName,
    String? filePath,
    String? fileType,
    int? fileSize,
    Map<String, dynamic>? fileMetadata,
  }) {
    return FileModel(
      fileID: fileID ?? this.fileID,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      fileMetadata: fileMetadata ?? this.fileMetadata,
    );
  }

  /// Converts the [FileModel] into a Map (useful for sending to a database or API)
  Map<String, dynamic> toMap() {
    return {
      'fileID': fileID,
      'fileName': fileName,
      'filePath': filePath,
      'fileType': fileType,
      'fileSize': fileSize,
      'fileMetadata': fileMetadata,
    };
  }

  /// Creates a [FileModel] from a Map (useful for fetching from a database or API)
  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      fileID: map['fileID'] as String,
      fileName: map['fileName'] as String,
      filePath: map['filePath'] as String,
      fileType: map['fileType'] as String,
      fileSize: map['fileSize'] as int,
      fileMetadata: map['fileMetadata'] as Map<String, dynamic>? ?? {},
    );
  }

  @override
  String toString() {
    return 'FileModel(fileID: $fileID, fileName: $fileName, fileType: $fileType, fileSize: $fileSize bytes)';
  }
}