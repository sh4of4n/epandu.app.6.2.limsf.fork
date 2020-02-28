import 'package:epandu/services/api/api_service.dart';
import 'package:epandu/services/api/bill_service.dart';
import 'package:epandu/services/api/model/language_model.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:epandu/utils/route_generator.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'app_localizations_delegate.dart';
import 'application.dart';
import 'services/api/get_base_url.dart';
import 'services/api/model/bill_model.dart';
import 'services/api/model/kpp_model.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(KppExamDataAdapter());
  // Hive.registerAdapter(EmergencyContactAdapter());
  Hive.registerAdapter(TelcoAdapter());
  Hive.registerAdapter(BillAdapter());
  _setupLogging();
  await Hive.openBox('ws_url');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageModel(),
        ),
        Provider(
          create: (context) => ApiService.create(),
          dispose: (context, ApiService service) => service.client.dispose(),
        ),
        Provider(
          create: (context) => GetBaseUrl.create(),
          dispose: (context, GetBaseUrl service) => service.client.dispose(),
        ),
        Provider(
          create: (context) => BillService.create(),
          dispose: (context, BillService service) => service.client.dispose(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizationsDelegate _newLocaleDelegate;
  final localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();

    _newLocaleDelegate = AppLocalizationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    String storedLocale = await localStorage.getLocale();

    onLocaleChange(Locale(storedLocale));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppLocalizationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePandu',
      theme: ThemeData(
        primaryColor: ColorConstant.primaryColor,
        textTheme: FontTheme().primaryFont,
        primaryTextTheme: FontTheme().primaryFont,
        accentTextTheme: FontTheme().primaryFont,
      ),
      // List all of the app's supported locales here
      supportedLocales: application.supportedLocales(),
      // These delegates make sure that the localization data for the proper language is loaded
      localizationsDelegates: [
        // THIS CLASS WILL BE ADDED LATER
        // A class which loads the translations from JSON files
        _newLocaleDelegate,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: AUTH,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    Hive.box('exam_data').compact();
    Hive.box('ws_url').compact();
    // Hive.box('emergencyContact').compact();
    Hive.close();
    super.dispose();
  }
}
