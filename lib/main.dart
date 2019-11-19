import 'package:epandu/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:epandu/utils/route_generator.dart';
import 'package:epandu/utils/route_path.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePandu',
      theme: ThemeData(
        primaryColor: ColorConstant.primaryColor,
      ),
      initialRoute: AUTH,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
