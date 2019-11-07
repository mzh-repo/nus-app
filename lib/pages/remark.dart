import 'package:flutter/material.dart';
import '../style/colors.dart';

class RemarkPage extends StatefulWidget {
  final content = '';

  @override
  _RemarkPageState createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nusBackgroundWhite,
      appBar: AppBar(
        title: Text('Process Results'),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        children: <Widget>[
          SizedBox(height: 40.0),
          Text(
            'Remark:',
            style: TextStyle(fontSize: 12.0, color: nusblack100),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 259.0,
            decoration: BoxDecoration(
                border: Border.all(color: nusblack10, width: 1.0),
                borderRadius: BorderRadius.circular(3.0)),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 259.0, horizontal: 20.0),
                hintText: 'Please add necessary remarks.',
                // contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
              height: 45,
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                color: nusGreen,
                child: (GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/result');
                    },
                    child: Center(
                        child: const Text(
                      'Captured',
                      style: TextStyle(fontSize: 16, color: nusBackgroundWhite),
                    )))),
              )),
          SizedBox(height: 10.0),
          Container(
              height: 45,
              child: Material(
                borderRadius: BorderRadius.circular(5.0),
                color: nusRed,
                child: (GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/result');
                    },
                    child: Center(
                        child: const Text(
                      'Escaped',
                      style: TextStyle(fontSize: 16, color: nusBackgroundWhite),
                    )))),
              )),
        ],
      ),
    );
  }
}
