import 'dart:io';

import 'package:file_share_application_frontend/core/Utils/image_picker.dart';
import 'package:file_share_application_frontend/global/Providers/AppSettingsNotifier.dart';
import 'package:file_share_application_frontend/global/Providers/CurrentUserNotifier.dart';
import 'package:file_share_application_frontend/global/models/app_settings.dart';
import 'package:file_share_application_frontend/repository/app_settings_repository.dart';
import 'package:file_share_application_frontend/repository/user_repository.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_image_model.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_setup_model.dart';
import 'package:file_share_application_frontend/ui/onboarding/profile_setup_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../core/Utils/helperFunctions.dart';
import '../../global/models/user_model.dart';

class ProfileSetupViewModel extends ChangeNotifier {
  final ProfileSetupModel profileModel;
  TextEditingController profileName = new TextEditingController();
  TextEditingController profileBio = new TextEditingController();
  List<ProfileImageModel> profileImages;
  ProfileImageModel selectedProfile;

  bool isLoading = false;
  bool isError = false;
  String errorData = "";

  final PageController pageController = PageController();

  ProfileSetupViewModel(this.profileModel)
    : profileImages = getAllProfileImages(),
      selectedProfile = ProfileImageModel(
        path: 'lib/assets/images/img_1.jpeg',
        name: 'Image 1',
      ) {
    handleProfileImageChange(
      ProfileImageModel(path: 'lib/assets/images/img_1.jpeg', name: 'Image 1'),
    );

    pageController.addListener(() {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void handleProfileImageChange(ProfileImageModel profileImage) async {
    try {
      final file = await getFileFromPath(profileImage);
      if (file == null) {
        throw ("Not able to read Assets File Path");
      }
      final byteString = await convertAssetToBase64(file);
      if (byteString == null) {
        throw ("Not able to Convert file to Base64 String");
      }
      profileModel.profileImage = byteString;
      selectedProfile = profileImage;
      notifyListeners();
    } catch (e) {
      print("Not able to Change Profile Image");
      return;
    }
  }

  void handleProfileImageSelectFromGallery() async {
    try {
      final file = await ProfileImageManager().pickImageFromGallery();
      if (file != null) {
        ProfileImageModel profileImageModel = ProfileImageModel(
          path: file.path,
          name: Path.basename(file.path),
          isAsset: false,
        );
        handleProfileImageChange(profileImageModel);
      }
    } catch (e) {
      print("Not able to read file from the Gallery");
    }
  }

  void handleProfileDetailsSubmit() {
    try {
      profileModel.name = profileName.value.text;
      profileModel.bio = profileBio.value.text;

      notifyListeners();
    } catch (e) {
      print(e);
      return;
    }
  }

  int getCurrentPageValue() {
    return pageController.hasClients ? pageController.page!.round() : 0;
  }

  bool showAndHideSkipButton() {
    // print("Page Value: " + getCurrentPageValue().toString());
    return getCurrentPageValue() == 0;
  }

  void handleChangePageView(int pageNumber) {
    pageController.animateToPage(
      pageNumber,
      duration: Duration(milliseconds: 5),
      curve: SawTooth(1),
    );
  }

  void saveProfileSettings() {
    try {} catch (e) {}
  }

  void handleFinishProfileSettings(
    AppSettingsNotifier appSettings,
    AppSettingsRepository appSettingsRepo,
    Currentusernotifier currentUser,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      var uuid = Uuid();

      final CompletedAppSettings = AppSettings(
        isFirstTime: false,
        currentTheme: appSettings.currentTheme,
        currentLanguage: appSettings.currentLanguage,
      );
      // appSettingsRepo.saveAppSettings(CompletedAppSettings);
      appSettings.saveToDatabase(CompletedAppSettings);
      final deviceInfo = await getDeviceInfo();

      final currentUserData = User(
        id: uuid.v6(),
        name: profileName.text,
        bio: profileBio.text,
        deviceUniqueId: uuid.v6(),
        createdAt: DateTime.now(),
        deviceName: deviceInfo.deviceName,
        deviceType: deviceInfo.deviceType,
        profileImage: profileModel.profileImage,
      );

      await currentUser.saveUserData(currentUserData);
      // userRepo.insertUserData(currentUserData);
    } catch (e) {
      isError = true;
      errorData = "Not able to finish profile setup";
      notifyListeners();
      print("Not able to finish profile setup");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // void handleThemeChange(String theme){
  //   try{
  //     profileModel.theme = theme;
  //     notifyListeners();
  //   }catch(e){
  //     print(e);
  //     return;
  //   }
  // }
  //
  // void handleLanguageChange(String lang){
  //   try{
  //     profileModel.language = lang;
  //     notifyListeners();
  //   }catch(e){
  //     print(e);
  //     return;
  //   }
  // }
}
