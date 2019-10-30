import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Alerts'),
      centerTitle: true,
      leading: Text(''),
    );
  }
}
