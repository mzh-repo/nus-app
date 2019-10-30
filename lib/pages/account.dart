import 'package:flutter/material.dart';
import 'package:nus_app/pages/style/colors.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Account'),
        centerTitle: true,
        leading: Text(''),
        elevation: 0, // 去除Appbar底部阴影
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
                  'Christina',
                  style: TextStyle(fontSize: 20, color: nusblack200),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'female',
                  style: TextStyle(fontSize: 16, color: nusblack100),
                ),
              ],
            ),
            const SizedBox(height: 162.0),
            Column(
              children: <Widget>[
                Text(
                  'Last login: 2019-09-28 00:00',
                  style: TextStyle(fontSize: 13, color: nusblack50),
                ),
                const SizedBox(height: 15.0),
                Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: RaisedButton(
                      color: nusGrey50,
                      child: const Text('Logout'),
                      elevation: 1.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
