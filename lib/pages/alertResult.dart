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
    return Scaffold(
      backgroundColor: nusBackgroundWhite,
      appBar: AppBar(title: Text('Results'), centerTitle: true, elevation: 0),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 97),
          children: <Widget>[
            Image.asset(imageList[i]),
            const SizedBox(height: 53.0),
            Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.only(left: 100, right: 100),
                child: Material(
                  borderRadius: BorderRadius.circular(50.0),
                  color: nusBlue,
                  child: (GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Center(
                          child: const Text(
                        'Return Alerts',
                        style:
                            TextStyle(fontSize: 16, color: nusBackgroundWhite),
                      )))),
                )),
          ],
        ),
      ),
    );
  }
}
