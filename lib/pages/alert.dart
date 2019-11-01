import 'package:flutter/material.dart';
import './style/colors.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  // List<Tab> tab = <Tab>[
  //   Tab(
  //     text: "选项卡1",
  //   ),
  //   Tab(
  //     text: "选项卡2",
  //   )
  // ];

  Widget _fontStyle(String name, double size, Color color,
      {FontWeight weight}) {
    return Text(
      name,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight ?? FontWeight.w500,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  List<Map> alerts = [
    {
      'time': '2019-07-31 4:09PM',
      'image':
          'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
      'name':
          'Eusoff Hall Eusoff Hall Eusoff HallEusoff Hall  HallEusoff Hall  HallEusoff Hall HallEusoff Hall',
      'level': 'Level 01',
      'toliet': 'Toliet A',
      'role': 'male'
    },
    {
      'time': '2019-07-31 4:09PM',
      'image':
          'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
      'name': 'Eusoff Hall',
      'level': 'Level 01',
      'toliet': 'Toliet A',
      'role': 'male'
    },
    {
      'time': '2019-07-31 4:09PM',
      'image':
          'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
      'name': 'Eusoff Hall',
      'level': 'Level 01',
      'toliet': 'Toliet A',
      'role': 'male'
    },
    {
      'time': '2019-07-31 4:09PM',
      'image':
          'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
      'name': 'Eusoff Hall',
      'level': 'Level 01',
      'toliet': 'Toliet A',
      'role': 'male'
    },
    {
      'time': '2019-07-31 4:09PM',
      'image':
          'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
      'name': 'Eusoff Hall',
      'level': 'Level 01',
      'toliet': 'Toliet A',
      'role': 'male'
    }
  ];

  Widget _buildAlert(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.only(bottom: 15.0),
        color: nusBackgroundWhite,
        padding: EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail');
          },
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _fontStyle(alerts[index]['time'], 12.0, nusblack200),
                  Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _fontStyle('Detail', 12.0, nusblack200),
                        Image.asset('assets/arrow_right.png'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                        image: NetworkImage(alerts[index]['image']),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: (Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _fontStyle(alerts[index]['name'], 18.0, nusblack200,
                                weight: FontWeight.w700),
                            SizedBox(
                              height: 14.0,
                            ),
                            Text(alerts[index]['level']),
                            Text(alerts[index]['toliet']),
                          ],
                        ),
                        Positioned(
                            right: 0.0,
                            bottom: 0.0,
                            // child: RaisedButton(
                            //   color: Colors.red,
                            //   elevation: 1.0,
                            //   shape: const BeveledRectangleBorder(
                            //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            //   ),
                            //   child: _fontStyle(
                            //       alerts[index]['role'], 12.0, nusBackgroundWhite),
                            //   onPressed: () {
                            //     Navigator.pushNamed(context, '/login');
                            //   },
                            // ),
                            child: Container(
                              width: 70.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                  color: nusRed,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              child: Center(
                                child: _fontStyle(alerts[index]['role'], 12.0,
                                    nusBackgroundWhite),
                              ),
                            ))
                      ],
                    )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: AppBar(
            title: Text('Alerts'),
            centerTitle: true,
            leading: Text(''),
            elevation: 0,
            // bottom: new TabBar(tabs: tab),
          ),
          // body: ListView.builder(
          //   itemCount: alerts.length,
          //   itemBuilder: _buildAlert,
          // )
          body: Container(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
              child: ListView.builder(
                itemCount: alerts.length,
                itemBuilder: _buildAlert,
              )),
        ));
  }
}
