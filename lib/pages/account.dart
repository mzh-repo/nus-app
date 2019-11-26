import 'package:flutter/material.dart';
// import 'package:nus_app/util/storage.dart';
import '../style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/http.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name;
  String gender;
  String time;

  @override
  void initState() {
    super.initState();
    // String data = StorageUtil.getStringItem('Name');
    // print(data);
    _getData();
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('Name');
      gender = prefs.getInt('Gender') == 1 ? 'Male' : 'Female';
      time = prefs.getString('Time');
    });
  }

  void _logout(BuildContext context) {
    DioUtil.post('/user/logout')
        .then((res) => {Navigator.pushNamed(context, '/login')});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      // backgroundColor: nusBackgroundWhite,
      appBar: new AppBar(
        title: Text('Account'),
        centerTitle: true,
        leading: Text(''),
        // backgroundColor: Colors.transparent,
        // brightness: Brightness.dark,
        // elevation: 0, // 去除Appbar底部阴影
        elevation: 0.5,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 60),
          children: <Widget>[
            Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://c-ssl.duitang.com/uploads/item/201704/27/20170427155254_Kctx8.thumb.700_0.jpeg'),
                  radius: 50.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: nusblack200),
                ),
                const SizedBox(height: 10.0),
                Text(
                  gender,
                  style: TextStyle(fontSize: 16, color: nusblack100),
                ),
              ],
            ),
            const SizedBox(height: 162.0),
            Column(
              children: <Widget>[
                Text(
                  'Last login: $time',
                  style: TextStyle(fontSize: 13, color: nusblack50),
                ),
                const SizedBox(height: 15.0),
                Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: (GestureDetector(
                      onTap: () => _logout(context),
                      child: Material(
                          borderRadius: BorderRadius.circular(5.0),
                          color: nusGrey50,
                          child: Center(
                              child: const Text(
                            'Logout',
                            style: TextStyle(fontSize: 16),
                          ))),
                    ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
