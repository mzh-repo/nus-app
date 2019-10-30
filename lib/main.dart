import 'package:flutter/material.dart';
import 'package:nus_app/pages/login.dart';
import 'package:nus_app/pages/home.dart';
import 'package:nus_app/pages/alertResult.dart';
import 'package:nus_app/pages/style/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NUS Camera',
      theme: ThemeData(primaryColor: nusBackgroundWhite),
      initialRoute: '/login',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => LoginPage(),
        '/result': (BuildContext context) => ResultPage()
      },
    );
  }
}
