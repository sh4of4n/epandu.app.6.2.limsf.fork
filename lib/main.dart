// import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'common_library/utils/app_localizations_delegate.dart';
import 'common_library/utils/application.dart';
import 'router.gr.dart' as router;
import 'package:epandu/common_library/services/model/bill_model.dart';
import 'package:epandu/common_library/services/model/kpp_model.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import 'services/provider/cart_status.dart';
// import 'package:logging/logging.dart';

/* final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final dynamic notification = message['notification'] ?? message;
  final String messageTitle = notification['title'];
  final String messageBody = notification['body'];
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(
      itemId,
      () => Item(
          messageTitle: messageTitle, messageBody: messageBody, itemId: itemId))
    ..status = data['status'];
  return item;
}

class Item {
  Item({this.messageTitle, this.messageBody, this.itemId});

  final String messageTitle;
  final String messageBody;
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => Authentication(
            messageTitle: messageTitle,
            messageBody: messageBody,
            itemId: itemId),
      ),
    );
  }
} */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(KppExamDataAdapter());
  // Hive.registerAdapter(EmergencyContactAdapter());
  Hive.registerAdapter(TelcoAdapter());
  Hive.registerAdapter(BillAdapter());
  // _setupLogging();
  await Hive.openBox('ws_url');

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CallStatusModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedsLoadingModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartStatus(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

// void _setupLogging() {
//   Logger.root.level = Level.ALL;
//   Logger.root.onRecord.listen((rec) {
//     print('${rec.level.name}: ${rec.time}: ${rec.message}');
//   });
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizationsDelegate _newLocaleDelegate;
  final localStorage = LocalStorage();
  final image = ImagesConstant();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _homeScreenText = "Waiting for token...";
  final customDialog = CustomDialog();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      // app is in foreground
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        setState(() {
          Hive.box('ws_url').put('show_badge', true);
        });
        // await Hive.box('ws_url').put('show_badge', true);
        // Provider.of<NotificationModel>(context, listen: false)
        //     .setNotification(true);
        // _showItemDialog(message);
      },
      // onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      // app is terminated
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        setState(() {
          Hive.box('ws_url').put('show_badge', true);
        });

        // Provider.of<NotificationModel>(context, listen: false)
        //     .setNotification(true);
        _navigateToItemDetail(message);
        // _showItemDialog(message);
      },
      // app is in background
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          Hive.box('ws_url').put('show_badge', true);
        });
        // await Hive.box('ws_url').put('show_badge', true);
        // Provider.of<NotificationModel>(context, listen: false)
        //     .setNotification(true);
        _navigateToItemDetail(message);
        // _showItemDialog(message);
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      Hive.box('ws_url').put('push_token', token);
      print(_homeScreenText);
    });

    _firebaseMessaging.requestNotificationPermissions();

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

  /* static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];

      print('Data: ' + data);
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];

      print('Notification: ' + notification);
    }

    // Or do other work.
  } */

/*   Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text(item.messageBody),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  } */

  /* void _showItemDialog(Map<String, dynamic> message) {
    customDialog.show(
      context: context,
      title: message['notification']['title'],
      content: Text(message['notification']['data']),
      customActions: [
        FlatButton(
          child: Text(AppLocalizations.of(context).translate('ok_btn')),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      type: DialogType.GENERAL,
    );

    /* showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    }); */
  } */

  void _navigateToItemDetail(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      switch (view) {
        case 'ENROLLMENT':
          ExtendedNavigator.of(context).push(router.Routes.enrollment);
          break;
        case 'KPP':
          ExtendedNavigator.of(context).push(router.Routes.kppCategory);
          break;
        case 'VCLUB':
          ExtendedNavigator.of(context).push(router.Routes.valueClub);
          break;
        case 'CHAT':
          ExtendedNavigator.of(context).push(router.Routes.chatHome);
          break;
      }
    }
    /* final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    } */
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(image.logo2), context);
    return MaterialApp(
      title: 'ePandu',
      theme: ThemeData(
        primaryColor: ColorConstant.primaryColor,
        fontFamily: 'Myriad',
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
      builder: ExtendedNavigator<router.Router>(
        initialRoute: router.Routes.authentication,
        router: router.Router(),
      ),
      // initialRoute: AUTH,
      // onGenerateRoute: RouteGenerator.generateRoute,
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
