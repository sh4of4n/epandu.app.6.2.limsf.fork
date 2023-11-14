import 'dart:ui';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLanguages = [
    "English",
    "Malay",
  ];

  final List<String> supportedLanguagesCodes = [
    "en",
    "ms",
  ];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  //function to be invoked when changing the language
  late LocaleChangeCallback onLocaleChanged;
}

Application application = Application();

typedef LocaleChangeCallback = void Function(Locale locale);
