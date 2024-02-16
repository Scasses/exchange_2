// import 'package:exchange/resources/AuthMethods.dart';
// import 'package:exchange/responsive/mobile_screen_layout.dart';
// import 'package:exchange/responsive/responsive_screen.dart';
// import 'package:exchange/responsive/web_screen_layout.dart';
// import 'package:exchange/screens/home_page.dart';
// import 'package:exchange/screens/signup.dart';
// import 'package:exchange/widgets/login_button.dart';
import 'package:exchange_app_2_0/screens/signup.dart';
import 'package:flutter/material.dart';

import '../resources/AuthMethods.dart';
import '../utilities/utils.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String response = await FirebaseAuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
    if (response == 'success') {
      response = 'Welcome to Exchange';
      showSnackBar(response, context);
    } else {
      showSnackBar(response, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              padding: const EdgeInsets.only(top: 45.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/exchangeS.png'),fit: BoxFit.cover,
                      ),
                    ),
                    // child: const Image(
                    //   image: AssetImage('images/exchangeS.png'),
                    // ),
                  ),
                  const Text(
                    'Join the discussion',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Type in your email address here...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Type in your password here...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 30,
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  LoginButton(
                    color: Colors.white,
                    title: 'Login',
                    onPressed: () {
                      loginUser();
                      print('Login clicked');
                    },
                    width: 300.0,
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Container(
              height: 140.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Not yet a member?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToSignUp(context);
                    },
                    child: const Text(
                      'Sign Up!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}