import 'package:flutter/material.dart';

import '../auth_credentials.dart';

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
  //username is an email address
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(children: [
        _background(),
        _cloud(),
        _toplogo(),
        // Sign Up Form
        _signUpForm(),
        Positioned(
          top: 200,
          left: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi there!',
                style: TextStyle(
                  color: Color(0xFFFDBC59),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Happy to have you on board!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Login Button
        Positioned(
          bottom: 70,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                    onPressed: widget.shouldShowLogin, child: Text('Log in.')),
              ],
            ),
          ),
        )
      ])),
    );
  }

  Widget _signUpForm() {
    return Center(
      child: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Name TextField
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle), labelText: 'Name'),
            ),
            // Email TextField
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

            // Sign Up Button
            TextButton(
              onPressed: _signUp,
              child: Text('Sign Up', style: TextStyle(color: Colors.black)),
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
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() {
    var nickname;
    if (_nicknameController.text.trim() == "") {
      nickname = "Friend";
    } else {
      nickname = _nicknameController.text.trim();
    }
    final username = _usernameController.text.trim();
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('nickname: $nickname');
    print('username: $username');
    print('email: $email');
    print('password: $password');

    final credentials = SignUpCredentials(
        nickname: nickname,
        username: username,
        email: email,
        password: password);
    widget.didProvideCredentials(credentials);
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
}
