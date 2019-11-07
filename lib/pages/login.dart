import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../style/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showToast() {
    Toast.show("Please contact admin office", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
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
              ),
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
              ),
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
                child: Material(
                  borderRadius: BorderRadius.circular(5.0),
                  color: nusGrey100,
                  child: (GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Center(
                          child: const Text(
                        'SIGN IN',
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
