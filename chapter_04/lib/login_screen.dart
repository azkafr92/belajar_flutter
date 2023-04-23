import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chapter_04/shared/firebase_authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FirebaseAuthentication auth;
  String _message = '';
  bool _isLogin = true;
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      auth = FirebaseAuthentication();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout().then((value) {
                if (value) {
                  setState(() {
                    _message = 'user logged out';
                  });
                } else {
                  _message = 'unable to log out';
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(36),
        child: ListView(
            children: [
              _userInput(),
              _passwordInput(),
              _btnMain(),
              _btnSecondary(),
              btnGoogle(),
              _txtMessage(),
            ],
        ),
      ),
    );
  }

  bool _checkNullOrEmpty(String? text) {
    if (text!.isNotEmpty) {
      return false;
    }
    return true;
  }

  Widget _userInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextFormField(
        controller: txtUsername,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'User name',
          icon: Icon(Icons.verified_user),
        ),
        validator: (text) => _checkNullOrEmpty(text) ? 'username required' : '',
      ),
    );
  }

  Widget _passwordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          hintText: 'Password',
          icon: Icon(Icons.enhanced_encryption),
        ),
        validator: (text) => _checkNullOrEmpty(text) ? 'password required' : '',
      ),
    );
  }

  Widget _btnMain() {
    String btnText = _isLogin ? 'Log in' : 'Sign up';
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  side: const BorderSide(color: Colors.red),
                )
            ),
          ),
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          onPressed: () {
            String userId = '';
            if (_isLogin) {
              auth.login(txtUsername.text, txtPassword.text).then((value) {
                if (value == null) {
                  setState(() {
                    _message = 'Login error';
                  });
                } else {
                  userId = value;
                  setState(() {
                    _message = 'User $userId successfully logged in';
                  });
                  // changeScreen();
                }
              });
            } else {
              auth.createUser(txtUsername.text, txtPassword.text).then((value) {
                if (value == null) {
                  setState(() {
                    _message = 'Registration error';
                  });
                } else {
                  userId = value;
                  setState(() {
                    _message = 'User $userId successfully registered';
                  });
                }
              });
            }
          },
        ),
      ),
    );
  }

  Widget _btnSecondary() {
    String btnText = _isLogin ? 'Sign up' : 'Login';
    return TextButton(
        onPressed: () {
          setState(() { _isLogin = !_isLogin; });
        },
        child: Text(btnText),
    );
  }

  Widget _txtMessage() {
    return Text(
      _message,
      style: TextStyle(
        fontSize: 16,
        color: Theme.of(context).primaryColorDark,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget btnGoogle() {
    return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColorLight),
              shape: MaterialStateProperty.all
              <RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: const BorderSide(color: Colors.red)),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Log in with Google',
              style: TextStyle(
                  fontSize: 18, color:
              Theme.of(context).primaryColorDark),
            ),
          ),
        ));
  }
}
