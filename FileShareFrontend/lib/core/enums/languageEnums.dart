enum LanguageEnums {
  hindi(code: 'hi', englishName: 'Hindi', nativeName: 'हिन्दी'),
  bengali(code: 'bn', englishName: 'Bengali', nativeName: 'বাংলা'),
  marathi(code: 'mr', englishName: 'Marathi', nativeName: 'मराठी'),
  telugu(code: 'te', englishName: 'Telugu', nativeName: 'తెలుగు'),
  tamil(code: 'ta', englishName: 'Tamil', nativeName: 'தமிழ்'),
  gujarati(code: 'gu', englishName: 'Gujarati', nativeName: 'ગુજરાતી'),
  urdu(code: 'ur', englishName: 'Urdu', nativeName: 'اُردُو'),
  kannada(code: 'kn', englishName: 'Kannada', nativeName: 'ಕನ್ನಡ'),
  odia(code: 'or', englishName: 'Odia', nativeName: 'ଓଡ଼ିଆ'),
  malayalam(code: 'ml', englishName: 'Malayalam', nativeName: 'മലയാളം'),
  punjabi(code: 'pa', englishName: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ'),
  assamese(code: 'as', englishName: 'Assamese', nativeName: 'অসমীয়া'),
  konkani(code: 'kok', englishName: 'Konkani', nativeName: 'कोंकणी'),
  kashmiri(code: 'ks', englishName: 'Kashmiri', nativeName: 'کٲشُر'),
  nepali(code: 'ne', englishName: 'Nepali', nativeName: 'नेपाली'),
  sanskrit(code: 'sa', englishName: 'Sanskrit', nativeName: 'संस्कृतम्'),
  sindhi(code: 'sd', englishName: 'Sindhi', nativeName: 'سنڌي');

  final String code;
  final String englishName;
  final String nativeName;

  const LanguageEnums({
    required this.code,
    required this.englishName,
    required this.nativeName,
  });

  /// Helper method to find an enum value from an ISO string code (e.g., 'hi')
  static LanguageEnums? fromCode(String code) {
    for (var language in LanguageEnums.values) {
      if (language.code == code) return language;
    }
    return null;
  }
}
