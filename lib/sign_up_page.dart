import 'package:flutter/material.dart';

import './auth_credentials.dart';
import './auth_service.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;

  final VoidCallback shouldShowLogin;

  SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  //currently username = email address
  //final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: widget.shouldShowLogin,
                  child: Text('Already have an account? Login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
          InputDecoration(icon: Icon(Icons.person), labelText: 'Email'),
        ),

        // // Email TextField
        // TextField(
        //   controller: _emailController,
        //   decoration:
        //   InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
        // ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // Sign Up Button
        FlatButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
            color: Theme.of(context).accentColor),
        ///////////////////////////////
        ///this button here just for testing
        /// delete in actual app
        FlatButton(
            child: Text('Logout'),
            onPressed: AuthService().logOut,
            color: Theme.of(context).accentColor)
        ///////////////////////////////
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');

    final credentials = SignUpCredentials(
        username: username,
        email: email,
        password: password
    );
    widget.didProvideCredentials(credentials);
  }
}