

enum FileCategoryEnum {
  image('Image'),
  video('Video'),
  audio('Audio'),
  document('Document'),
  archive('Archive'),
  apk('APK / App'),
  unknown('Unknown');

  final String displayName;

  const FileCategoryEnum(this.displayName);

  /// Helper method to convert a string (like from a database) back to the enum
  static FileCategoryEnum fromString(String category) {
    return FileCategoryEnum.values.firstWhere(
          (e) => e.name == category || e.displayName == category,
      orElse: () => FileCategoryEnum.unknown,
    );
  }

  /// Helper method to automatically determine the category from a file extension
  static FileCategoryEnum getCategoryFromExtension(String extension) {
    final ext = extension.toLowerCase().replaceAll('.', ''); // Ensure no dot

    switch (ext) {
    // Images
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'webp':
      case 'svg':
        return FileCategoryEnum.image;

    // Videos
      case 'mp4':
      case 'avi':
      case 'mkv':
      case 'mov':
      case 'webm':
        return FileCategoryEnum.video;

    // Audio
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'm4a':
      case 'ogg':
        return FileCategoryEnum.audio;

    // Documents
      case 'pdf':
      case 'doc':
      case 'docx':
      case 'xls':
      case 'xlsx':
      case 'ppt':
      case 'pptx':
      case 'txt':
        return FileCategoryEnum.document;

    // Archives
      case 'zip':
      case 'rar':
      case '7z':
      case 'tar':
      case 'gz':
        return FileCategoryEnum.archive;

    // Apps / Executables
      case 'apk':
      case 'aab':
        return FileCategoryEnum.apk;

      default:
        return FileCategoryEnum.unknown;
    }
  }
}