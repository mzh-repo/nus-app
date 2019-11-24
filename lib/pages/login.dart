import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../style/colors.dart';
import '../util/http.dart';
// import '../util/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showBtn = false;

  void showToast() {
    Toast.show("Please contact admin office", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void login(BuildContext context) {
    if (_showBtn) {
      var data = {
        "account": _usernameController.text,
        "password": _passwordController.text
      };
      DioUtil.request('/user/login', formData: data)
          .then((res) =>
              {_setStorage(res.data), Navigator.popAndPushNamed(context, '/')})
          .catchError((e) => {
                print(e),
                Toast.show("Account or password incorrect", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER),
              });
    }
  }

  _setStorage(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Token', data['login_token']);
    prefs.setString('Name', data['name']);
    prefs.setInt('Gender', data['gender']);
    prefs.setString('Time', data['last_login_time']);
  }

  void _vaild() {
    if (_usernameController.text != '' && _passwordController.text != '') {
      setState(() {
        _showBtn = true;
      });
    } else {
      setState(() {
        _showBtn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/logo.png'),
                const SizedBox(height: 20.0),
                Text(
                  'Welcome to',
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  'Smart Camera System',
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
            const SizedBox(height: 62.0),
            PrimaryColorOverride(
              color: nusUnderline,
              child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  onChanged: (val) {
                    _vaild();
                  }),
            ),
            const SizedBox(height: 12.0),
            PrimaryColorOverride(
              color: nusUnderline,
              child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (val) {
                    _vaild();
                  }),
            ),
            const SizedBox(height: 12.0),
            GestureDetector(
              onTap: showToast,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Forgot Password or Need A New Account?',
                    style: TextStyle(fontSize: 12, color: nusblack100),
                  )
                ],
              ),
            ),
            const SizedBox(height: 56.0),
            Container(
                height: 45,
                child: (GestureDetector(
                  onTap: () =>
                      // Navigator.pushNamed(context, '/');
                      login(context),
                  child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      color: _showBtn ? nusBlue : nusGrey100,
                      child: Center(
                          child: const Text(
                        'SIGN IN',
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

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}
