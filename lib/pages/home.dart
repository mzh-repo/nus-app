import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../pages/alert.dart';
import '../pages/dashboard.dart';
import '../pages/account.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _fireBaseMessaging = FirebaseMessaging();

  final List<Widget> pages = [
    AlertPage(),
    DashboardPage(),
    AccountPage(),
  ];
  int _currentIndex = 0;
  void _ontap(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
    super.initState();

    //push notification
    _fireBaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fireBaseMessaging.getToken().then((token) {
      if (token != null) {
        _postFcm(token); //推送的post请求
      }
    });
    // get notify in application
    _fireBaseMessaging.configure(onMessage: (Map message) {
      handleMessage(message);
    }, onLaunch: (Map message) {
      handleMessage(message);
    }, onResume: (Map message) {
      handleMessage(message);
    });
  }

  //推送的post请求
  Future _postFcm(String token) async {
    setState(() {
      _currentIndex = 0;
    });

    // token: 指定设备的消息推送
    //     String url = url;
    //     var data = {"token": token};
    //     DioUtil.post(url, data: data).then((response) {
    //   });
    // }
  }

  void handleMessage(Map message) {
    setState(() {
      var data = message["data"];
      print('fcm:$data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: nusblack20,
        selectedItemColor: nusblack200,
        items: [
          BottomNavigationBarItem(
              icon: Image(
                height: 21,
                width: 21,
                image: AssetImage('assets/alert.png'),
              ),
              activeIcon: Image(
                height: 21,
                width: 21,
                image: AssetImage('assets/alert_chosed.png'),
              ),
              title: Text('Alerts')),
          BottomNavigationBarItem(
              icon: Image(
                height: 21,
                width: 21,
                image: AssetImage('assets/dashboard.png'),
              ),
              activeIcon: Image(
                image: AssetImage('assets/dashboard_chosed.png'),
                height: 21,
                width: 21,
              ),
              title: Text('Dashboard')),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/account.png'),
                height: 21,
                width: 21,
              ),
              activeIcon: Image(
                image: AssetImage('assets/account_chosed.png'),
                height: 21,
                width: 21,
              ),
              title: Text('Account')),
        ],
        currentIndex: _currentIndex,
        onTap: _ontap,
      ),
      body: IndexedStack(index: _currentIndex, children: pages),
    );
  }
}
