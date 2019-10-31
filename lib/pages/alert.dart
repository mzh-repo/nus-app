import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  List<Tab> tab = <Tab>[
    Tab(
      text: "选项卡1",
    ),
    Tab(
      text: "选项卡2",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: AppBar(
              title: Text('Alerts'),
              centerTitle: true,
              leading: Text(''),
              bottom: new TabBar(tabs: tab),
            ),
            body: new TabBarView(
              children: tab.map((Tab tab) {
                return Center(child: new Text(tab.text));
              }).toList(),
            )));
  }
}
