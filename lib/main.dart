import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:epandu/utils/route_generator.dart';
import 'package:epandu/utils/route_path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

import 'services/api/model/kpp_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(KppExamDataAdapter(), 0);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      initialRoute: AUTH,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    Hive.box('exam_data').compact();
    Hive.close();
    super.dispose();
  }
}
