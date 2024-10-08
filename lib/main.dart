// import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:epandu/common_library/services/model/inbox_model.dart';
import 'package:epandu/common_library/services/model/provider_model.dart';
import 'package:epandu/common_library/services/repository/inbox_repository.dart';
import 'package:epandu/pages/chat/rooms_provider.dart';
import 'package:epandu/pages/chat/socketclient_helper.dart';
import 'package:epandu/router.dart';
import 'package:epandu/router.gr.dart';
import 'package:epandu/services/database/database_helper.dart';
import 'package:epandu/services/provider/notification_count.dart';
import 'package:epandu/utils/constants.dart';
import 'package:epandu/common_library/utils/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'common_library/services/model/auth_model.dart';
import 'common_library/utils/app_localizations_delegate.dart';
import 'common_library/utils/application.dart';
import 'package:epandu/common_library/services/model/bill_model.dart';
import 'package:epandu/common_library/services/model/kpp_model.dart';
import 'package:epandu/common_library/utils/custom_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import 'pages/chat/chat_history.dart';
import 'pages/chat/chatnotification_count.dart';
import 'pages/chat/online_users.dart';
import 'services/provider/cart_status.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
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
const channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.',
  importance: Importance.high,
  playSound: true,
);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.data}');
  print(
      'A Background message just showed up :  ${message.notification!.title!}-${message.notification!.body!}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

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
  await Hive.openBox('menu');

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

//Firebase messaging
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();

  // runZonedGuarded(() async {
  setupSentry(
    () => runApp(
      DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) {
            return MultiProvider(
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
                ChangeNotifierProvider(
                  create: (context) => ChatNotificationCount(),
                ),
                ChangeNotifierProvider(
                    create: (context) => OnlineUsers(context)),
                ChangeNotifierProvider(create: (context) => ChatHistory()),
                ChangeNotifierProvider(create: (context) => RoomHistory()),
                ChangeNotifierProvider(
                    create: (context) => SocketClientHelper(context)),
              ],
              child: SentryScreenshotWidget(
                child: SentryUserInteractionWidget(
                  child: DefaultAssetBundle(
                    bundle: SentryAssetBundle(),
                    child: const MyApp(),
                  ),
                ),
              ),
            );
          }),
    ),
  );

  configLoading();
}

Future<void> setupSentry(AppRunner appRunner,
    {bool isIntegrationTest = false,
    BeforeSendCallback? beforeSendCallback}) async {
  await SentryFlutter.init((options) {
    options.dsn =
        'https://5525bd569e8849f0940925f93c1b164a@o354605.ingest.sentry.io/6739433';
    options.tracesSampleRate = 1.0;
    options.attachThreads = true;
    options.enableWindowMetricBreadcrumbs = true;
    options.sendDefaultPii = true;
    options.reportSilentFlutterErrors = true;
    options.attachScreenshot = true;
    options.screenshotQuality = SentryScreenshotQuality.low;
    options.attachViewHierarchy = true;
    options.maxRequestBodySize = MaxRequestBodySize.always;
    options.maxResponseBodySize = MaxResponseBodySize.always;
  },
      // Init your App.
      appRunner: appRunner);
}

// void _setupLogging() {
//   Logger.root.level = Level.ALL;
//   Logger.root.onRecord.listen((rec) {
//     print('${rec.level.name}: ${rec.time}: ${rec.message}');
//   });
// }
void configLoading() {
  EasyLoading.instance
    // ..displayDuration = const Duration(milliseconds: 2000)
    // ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    // ..loadingStyle = EasyLoadingStyle.dark
    // ..indicatorSize = 45.0
    // ..radius = 10.0
    // ..progressColor = Colors.yellow
    // ..backgroundColor = Colors.green
    // ..indicatorColor = Colors.yellow
    // ..textColor = Colors.yellow
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    // ..dismissOnTap = false
    // ..customAnimation = CustomAnimation()
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbHelper = DatabaseHelper.instance;
  late io.Socket socket;
  String userId = '';
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
    context.read<SocketClientHelper>().initSocket();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");

      getUnreadNotificationCount();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      print('Got a message whilst in the FOREGROUND!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('Message data: ${message.data}');
      // NotificationPayload notificationPayload =
      //     NotificationPayload.fromJson(message.data);
      if (notification != null && android != null) {
        if (await Hive.box('ws_url').get('isInChatRoom') == null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                    priority: Priority.high,
                    ticker: 'ticker'),
              ));
        }
      }
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

    _newLocaleDelegate = const AppLocalizationsDelegate(newLocale: null);
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
    if (!context.mounted) return;
    if (result.isSuccess) {
      if (int.tryParse(result.data[0].msgCount)! > 0) {
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: true,
        );

        Provider.of<NotificationCount>(context, listen: false)
            .updateNotificationBadge(
          notificationBadge: int.tryParse(result.data[0].msgCount),
        );
      } else {
        Provider.of<NotificationCount>(context, listen: false).setShowBadge(
          showBadge: false,
        );
      }
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
          router.push(const Enrollment());
          break;
        case 'KPP':
          // ExtendedNavigator.of(context).push(router.kppCategory);
          router.push(const KppCategory());
          break;
        case 'VCLUB':
          // ExtendedNavigator.of(context).push(router.Routes.valueClub);
          router.push(const ValueClub());
          break;
        case 'CHAT':
          // ExtendedNavigator.of(context).push(router.Routes.chatHome);
          router.push(const ChatHome());
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorConstant.primaryColor,
        fontFamily: 'Myriad',
        textTheme: FontTheme().primaryFont,
        primaryTextTheme: FontTheme().primaryFont,
        appBarTheme: const AppBarTheme(
          color: Color(0xffffd225),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
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
        FormBuilderLocalizations.delegate,
      ],
      // routerDelegate: _appRouter.delegate(initialRoutes: [const Authentication()]),
      //routeInformationParser: _appRouter.defaultRouteParser(),
      builder: EasyLoading.init(),
      routerConfig: _appRouter.config(
          navigatorObservers: () => [SentryNavigatorObserver()],
          deepLinkBuilder: (deepLink) {
            print('deeplink: ${deepLink.path}');
            if (deepLink.path.startsWith('/products')) {
              // continute with the platfrom link
              return deepLink;
            } else {
              return DeepLink.defaultPath;
              // or DeepLink.path('/')
              // or DeepLink([HomeRoute()])
            }
          }),
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
