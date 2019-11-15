import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../util/http.dart';

class RemarkPage extends StatefulWidget {
  final content = '';

  @override
  _RemarkPageState createState() => _RemarkPageState();
}

class _RemarkPageState extends State<RemarkPage> {
  final TextEditingController _remarkController = TextEditingController();

  void _goResult(context, int id, int i) {
    var data = {'remark': _remarkController.text};
    if (i == 0) {
      DioUtil.put('/alarm/$id/process/captured', formData: data);
    } else {
      DioUtil.put('/alarm/$id/process/escaped', formData: data);
    }
    Navigator.pushNamed(context, '/result', arguments: i);
  }

  @override
  Widget build(BuildContext context) {
    // 不同类型的结果
    int id = ModalRoute.of(context).settings.arguments;
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
              controller: _remarkController,
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
              child: (GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/result', arguments: 0);
                  _goResult(context, id, 0);
                },
                child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: nusGreen,
                    child: Center(
                        child: const Text(
                      'Captured',
                      style: TextStyle(fontSize: 16, color: nusBackgroundWhite),
                    ))),
              ))),
          SizedBox(height: 10.0),
          Container(
              height: 45,
              child: (GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/result', arguments: 3);
                  _goResult(context, id, 3);
                },
                child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: nusRed,
                    child: Center(
                        child: const Text(
                      'Escaped',
                      style: TextStyle(fontSize: 16, color: nusBackgroundWhite),
                    ))),
              ))),
        ],
      ),
    );
  }
}
