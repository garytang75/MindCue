import 'package:flutter/material.dart';

import '../auth_credentials.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback shouldShowSignUp;
  final ValueChanged<LoginCredentials> didProvideCredentials;

  LoginPage({Key key, this.didProvideCredentials, this.shouldShowSignUp})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // keep track of that state by TextEditingController for each field
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // safe area to make sure properly visible on different devices
      body: Container(
          child: Stack(
        children: [
          //top logo widget
          _toplogo(),
          //cloud positioned widget
          _cloud(),
          //background bottom positioned widget
          _background(),
          // Login Form
          _loginForm(),
          Positioned(
            top: 200,
            left: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey!',
                  style: TextStyle(
                    color: Color(0xFFFDBC59),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Happy to see you again!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Sign Up Button
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                      onPressed: widget.shouldShowSignUp,
                      child: Text('Sign up.')),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  // UI for the username and password text fields, login button
  Widget _loginForm() {
    return Center(
      child: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username TextField
            TextField(
              controller: _usernameController,
              decoration:
                  InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
            ),

            // Password TextField
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_open), labelText: 'Password'),
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),

            // Login Button
            TextButton(
              onPressed: _login,
              child: Text('Log in', style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFFCEE2EE)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xFFCEE2EE)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: Image.asset(
        'assets/icon/back.png',
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomLeft,
      ),
    );
  }

//top logo widget
  Widget _toplogo() {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Wrap(
          children: [
            Image.asset(
              'assets/icon/logo2.png',
              alignment: Alignment.topCenter,
              height: 150,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cloud() {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Wrap(
          children: [
            Image.asset(
              'assets/icon/cloud.png',
              height: 275,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    final credentials =
        LoginCredentials(username: username, password: password);
    widget.didProvideCredentials(credentials);
  }
}
