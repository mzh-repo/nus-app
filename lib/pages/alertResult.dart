import 'package:flutter/material.dart';
import '../style/colors.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List imageList = [
    'assets/result_1.png',
    'assets/result_2.png',
    'assets/result_3.png',
    'assets/result_4.png',
  ];
  int i = 1;

  @override
  Widget build(BuildContext context) {
    // 不同类型的结果
    var type = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: nusBackgroundWhite,
      appBar: AppBar(
          title: Text('Results'),
          leading: Text(''),
          centerTitle: true,
          elevation: 0),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 97),
          children: <Widget>[
            Image.asset(imageList[type]),
            const SizedBox(height: 53.0),
            Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.only(left: 100, right: 100),
                child: (GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Material(
                      borderRadius: BorderRadius.circular(50.0),
                      color: nusBlue,
                      child: Center(
                          child: const Text(
                        'Return Alerts',
                        style:
                            TextStyle(fontSize: 16, color: nusBackgroundWhite),
                      ))),
                ))),
          ],
        ),
      ),
    );
  }
}
