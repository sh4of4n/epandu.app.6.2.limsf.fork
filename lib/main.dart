// import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:epandu/common_library/services/model/inbox_model.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/services/provider/notification_count.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'common_library/services/model/auth_model.dart';
import 'common_library/utils/app_localizations_delegate.dart';
import 'common_library/utils/application.dart';
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
  Hive.registerAdapter(MsgOutboxAdapter());
  Hive.registerAdapter(DiListAdapter());
  // _setupLogging();
  await Hive.openBox('ws_url');
  await Hive.openBox('di_list');

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();

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
          create: (context) => HomeLoadingModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartStatus(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationCount(),
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
  AppLocalizationsDelegate? _newLocaleDelegate;
  final localStorage = LocalStorage();
  final image = ImagesConstant();
  final inboxRepo = InboxRepo();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _homeScreenText = "Waiting for token...";
  final customDialog = CustomDialog();
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");

      getUnreadNotificationCount();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");

      getUnreadNotificationCount();

      _navigateToItemDetail(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: true,
      announcement: false,
      criticalAlert: false,
      carPlay: false,
    );

    /* _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    }); */
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      Hive.box('ws_url').put('push_token', token);
      print(_homeScreenText);
    });

    // _firebaseMessaging.requestPermission();

    _newLocaleDelegate = AppLocalizationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    String storedLocale = (await localStorage.getLocale())!;

    onLocaleChange(Locale(storedLocale));
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppLocalizationsDelegate(newLocale: locale);
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');

    getUnreadNotificationCount();

    _navigateToItemDetail(message);
  }

  Future<void> getUnreadNotificationCount() async {
    var result = await inboxRepo.getUnreadNotificationCount();

    if (result.isSuccess) {
      if (int.tryParse(result.data[0].msgCount)! > 0) {
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: true,
        );

        Provider.of<NotificationCount>(context, listen: false)
            .updateNotificationBadge(
          notificationBadge: int.tryParse(result.data[0].msgCount),
        );
      } else
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: false,
        );
    } else {
      Provider.of<NotificationCount>(context, listen: false).setShowBadge(
        showBadge: false,
      );
    }
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
        TextButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        TextButton(
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
        TextButton(
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

  void _navigateToItemDetail(RemoteMessage message) {
    var notificationData = message.data;
    var view = notificationData['view'];
    StackRouter router = AutoRouter.of(context);

    if (view != null) {
      switch (view) {
        case 'ENROLLMENT':
          // ExtendedNavigator.of(context).push(router.enrollment);
          router.push(Enrollment());
          break;
        case 'KPP':
          // ExtendedNavigator.of(context).push(router.kppCategory);
          router.push(KppCategory());
          break;
        case 'VCLUB':
          // ExtendedNavigator.of(context).push(router.Routes.valueClub);
          router.push(ValueClub());
          break;
        case 'CHAT':
          // ExtendedNavigator.of(context).push(router.Routes.chatHome);
          router.push(ChatHome());
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
    return MaterialApp.router(
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
        _newLocaleDelegate!,
        // Built-in localization of basic text for Material widgets
        GlobalMaterialLocalizations.delegate,
        // Built-in localization for text direction LTR/RTL
        GlobalWidgetsLocalizations.delegate,
      ],
      routerDelegate: _appRouter.delegate(initialRoutes: [Authentication()]),
      routeInformationParser: _appRouter.defaultRouteParser(),
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
