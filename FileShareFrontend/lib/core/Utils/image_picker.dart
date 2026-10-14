import 'dart:io';
import 'package:image_picker/image_picker.dart'; // 👈 Make sure to add this import

class ProfileImageManager {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      // 🟢 Triggers native intent sheet opening standard system gallery layout
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Compresses image to 85% to keep storage footprint low
      );

      // Return physical reference if user didn't cancel selection
      if (pickedFile != null) {
        return File(pickedFile.path); // Returns valid physical File instantly!
      }
      return null;
    } catch (e) {
      print("Error opening device gallery layout context: $e");
      return null;
    }
  }
}
