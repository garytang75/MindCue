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
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            Container(
              height: 200,
              child: Image(image: AssetImage('assets/icon/logo.png')),
            ),
            // Login Form
            _loginForm(),
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: widget.shouldShowSignUp,
                  child: Text('Don\'t have an account? Sign up.')),
            )
          ])),
    );
  }

  // UI for the username and password text fields, login button
  Widget _loginForm() {
    return Column(
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
        FlatButton(
            onPressed: _login,
            child: Text('Log in'),
            color: Theme.of(context).accentColor)
      ],
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
