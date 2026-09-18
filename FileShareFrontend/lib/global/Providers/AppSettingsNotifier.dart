

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/enums/languageEnums.dart';

class Appsettingsnotifier extends ChangeNotifier{
  ThemeMode currentTheme;
  String currentLanguage;

  Appsettingsnotifier({
    required this.currentTheme,
    required this.currentLanguage
  });

  void toggleTheme(){
    if(currentTheme == ThemeMode.dark){
      currentTheme = ThemeMode.light;
    }else{
      currentTheme = ThemeMode.dark;
    }

    notifyListeners();
  }

  void handleChangeLanguage(LanguageEnums langauge){
    if(currentLanguage == langauge.code) return;
    currentLanguage = langauge.code;
    notifyListeners();
  }
}