import 'dart:io';

import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'dart:convert'; // Required for base64Encode
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

List<ProfileImageModel> getAllProfileImages() {
  return [
    ProfileImageModel(path: 'lib/assets/images/img_1.jpeg', name: 'Image 1'),
    ProfileImageModel(path: 'lib/assets/images/img_2.jpeg', name: 'Image 2'),
    ProfileImageModel(path: 'lib/assets/images/img_3.jpeg', name: 'Image 3'),
    ProfileImageModel(path: 'lib/assets/images/img_4.jpeg', name: 'Image 4'),
    ProfileImageModel(path: 'lib/assets/images/img_5.jpeg', name: 'Image 5'),
    ProfileImageModel(path: 'lib/assets/images/img_6.jpeg', name: 'Image 6'),
    ProfileImageModel(path: 'lib/assets/images/img_7.jpeg', name: 'Image 7'),
    ProfileImageModel(path: 'lib/assets/images/img_8.jpeg', name: 'Image 8'),
  ];
}

Future<String?> convertAssetToBase64(File file) async {
  try {
    // 2. Convert the byte buffer into a Uint8List (list of unsigned 8-bit integers)
    final bytes = await file.readAsBytes();

    // 3. Encode the byte list into a Base64 string
    final base64String = base64Encode(bytes);

    return base64String;
  } catch (e) {
    print('Error converting asset to base64: $e');
    return null;
  }
}

Future<File?> getFileFromPath(ProfileImageModel selectedImage) async {
  if (!selectedImage.isAsset) {
    // It's already a device file (e.g., from image_picker), just return it
    return File(selectedImage.path);
  }

  // It's an asset, so we convert it to a temp file (using the method from before)
  try {
    final byteData = await rootBundle.load(selectedImage.path);
    final tempDir = await getTemporaryDirectory();
    final fileName = selectedImage.path.split('/').last;
    final file = File('${tempDir.path}/$fileName');

    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );

    return file;
  } catch (e) {
    print("Error converting asset: $e");
    return null;
  }
}
