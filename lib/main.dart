import 'package:flutter/material.dart';
import 'package:nus_app/pages/remark.dart';
import './pages/login.dart';
import './pages/home.dart';
import './pages/alertResult.dart';
import './pages/style/colors.dart';
import './pages/alertDetail.dart';
import './pages/remark.dart';

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
      theme: ThemeData(
        primaryColor: nusBackgroundWhite,
      ),
      initialRoute: '/login',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => LoginPage(),
        '/result': (BuildContext context) => ResultPage(),
        '/detail': (BuildContext context) => DetailPage(),
        '/remark': (BuildContext context) => RemarkPage()
      },
    );
  }
}
