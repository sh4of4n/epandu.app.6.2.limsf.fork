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
        primarySwatch: Colors.blue,
      ),
      initialRoute: HOME,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
