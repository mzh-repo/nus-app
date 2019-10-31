import 'package:flutter/material.dart';
import './style/colors.dart';

class Post {
  final String title;
  final String image;
  final String subTitle;

  const Post({this.title, this.subTitle, this.image});
}

final List<Post> posts = [
  Post(
    title: '疯狂动物城',
    subTitle: 'Level 2 - Female Restroom A',
    image: 'http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',
  ),
  Post(
    title: '中国蓝盔',
    subTitle: 'Level 2 - Female Restroom A',
    image: 'http://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg',
  ),
  Post(
    title: '克隆人',
    subTitle: 'Level 2 - Female Restroom A',
    image: 'http://img5.mtime.cn/mt/2018/11/13/093605.61422332_180X260X4.jpg',
  ),
  Post(
    title: '龙猫',
    subTitle: 'Level 2 - Female Restroom A',
    image: 'http://img5.mtime.cn/mt/2018/11/07/092515.55805319_180X260X4.jpg',
  ),
  Post(
    title: '恐怖快递',
    subTitle: 'Level 2 - Female Restroom A',
    image: 'http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',
  ),
];

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int processNum = 25;
  int totalNum = 306;

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
                image: DecorationImage(
                  image: NetworkImage(posts[index].image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(posts[index].title),
                SizedBox(height: 10.0),
                Text(posts[index].subTitle)
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
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
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
                    // width: 500,
                    // height: 500,
                    child: Scrollbar(
                        child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: _buildListItem,
            )))),
          ],
        ),
      )),
    );
  }
}
