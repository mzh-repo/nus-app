import 'dart:convert';

import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../util/http.dart';

class Post {
  final String title;
  final String image;
  final String subTitle;

  const Post({this.title, this.subTitle, this.image});
}

final List<Map> list = [
  {
    'title': '疯狂动物城',
    'subTitle': 'Level 2 - Female Restroom A',
    'image': 'http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
  },
  {
    'title': '疯狂动物城',
    'subTitle': 'Level 2 - Female Restroom A',
    'image': 'http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
  },
  {
    'title': '疯狂动物城',
    'subTitle': 'Level 2 - Female Restroom A',
    'image': 'http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
  },
];

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int processNum = 25;
  int totalNum = 306;
  List list = new List();
  List imageList = new List();
  int _page = 0;
  int _pageSize = 10;
  ScrollController _scrollController = ScrollController(); // listview 控制器
  bool isLoading = false; //是否正在加载数据

  var moreData;

  @override
  void initState() {
    super.initState();
    _getBasic();
    _alertList(_page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore(_page++);
      }
    });
  }

  void _getBasic() {
    DioUtil.request('/index/dashboard').then((res) => {
          setState(() {
            processNum = res.data['processed_alarm_number'];
            totalNum = res.data['total_alarm_number'];
          }),
        });
  }

  void _alertList(int page) {
    DioUtil.request('/camera/failure_list?page=$_page&&page_size=$_pageSize')
        .then((res) => {
              setState(() {
                list = res.data['data'];
              })
            });
  }

  Future _getMore(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      DioUtil.request('/camera/failure_list?page=$_page&&page_size=$_pageSize')
          .then((res) => {
                moreData = res['data'],
                setState(() {
                  list.addAll(List.generate(moreData.length, (item) => item));
                  isLoading = false;
                })
              });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom:
                    Divider.createBorderSide(context, color: nusUnderline))),
        child: (Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6.0),
                // TODO
                image: DecorationImage(
                  // image: NetworkImage(list[index]['image']),
                  image: AssetImage('assets/alert.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(list[index]['region']),
                SizedBox(height: 10.0),
                Text('${list[index]['level']} - ${list[index]['room']} ')
              ],
            ),
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: nusBackgroundWhite,
      appBar: AppBar(
          title: Text('Dashboard'),
          centerTitle: true,
          leading: Text(''),
          elevation: 0),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 40.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'I have Processed ${processNum.toString()} alerts',
              style: TextStyle(fontSize: 16, color: nusblack200),
            ),
            SizedBox(height: 9.0),
            Text('Total Alerts: ' + totalNum.toString(),
                style: TextStyle(fontSize: 13, color: nusblack200)),
            SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Camera Failure List ',
                    style: TextStyle(fontSize: 13, color: nusblack50)),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
                child: Container(
                    child: Scrollbar(
                        child: ListView.builder(
              itemCount: list.length,
              itemBuilder: _buildListItem,
            )))),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
