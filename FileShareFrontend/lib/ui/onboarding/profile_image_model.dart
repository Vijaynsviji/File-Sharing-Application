import '../../core/enums/image_source_enum.dart';

class ProfileImageModel {
  String path;
  String name;
  bool isAsset;

  final ImageSourceType sourceType;

  ProfileImageModel({
    required this.path,
    required this.name,
    this.isAsset = true,

    this.sourceType = ImageSourceType.asset,
  });
}
