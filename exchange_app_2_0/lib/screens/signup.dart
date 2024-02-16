// import 'package:exchange/resources/AuthMethods.dart';
// import 'package:exchange/responsive/mobile_screen_layout.dart';
// import 'package:exchange/responsive/responsive_screen.dart';
// import 'package:exchange/responsive/web_screen_layout.dart';
import 'package:flutter/material.dart';
import '../resources/AuthMethods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../widgets/login_button.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordverify = TextEditingController();
  final TextEditingController _userQuote = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _username.dispose();
    _password.dispose();
    _passwordverify.dispose();
    _userQuote.dispose();
    super.dispose();
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String response = await FirebaseAuthMethods().signUpUser(
      email: _email.text,
      password: _password.text,
      userName: _username.text,
      name: _name.text,
      quote: _userQuote.text, context: context,
    );

    setState(
          () {
        _isLoading = false;

        if (response != 'success') {
          print(response);
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              ),
            ),
          );
          print('This was successful.');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey,
              // Color(0xff075b9a),
            ],
            stops: [0.4, 1.0],
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 25, 15.0, 8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 80.0,
                      width: 80.0,
                      child: const Image(
                        image: AssetImage('images/exchangeS.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: const Column(
                children: <Widget>[
                  Text(
                    'Sign up ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
              indent: 1.0,
              endIndent: 3.0,
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tell us your name...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _name,
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What shall we call you on Exchange(Username)...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _username,
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What is your email address...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _email,
                obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Now get creative, password time...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _password,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText:
                  'Let\'s just make sure you remember your password...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _passwordverify,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Give us an interesting quote(preferably yours)...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _userQuote,
                obscureText: false,
              ),
            ),
            LoginButton(
              color: Colors.white,
              title: 'Sign up',
              onPressed: () {
                signUpUser();
                print('Login clicked');
              },
              width: 300.0,
              height: 20.0,
            ),
            Container(
              height: 92.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already a member?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToLogin(context);
                    },
                    child: const Text(
                      'Login!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}