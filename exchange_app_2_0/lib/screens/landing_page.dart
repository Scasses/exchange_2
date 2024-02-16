import 'package:exchange_app_2_0/screens/signup.dart';
import 'package:flutter/material.dart';

import '../widgets/login_button.dart';
import 'login.dart';




class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              width: 500,
              child: const Opacity(
                opacity: .6,
                child: Image(
                  image: AssetImage('images/exchangesym.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 200.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LoginButton(
                  height: 15.0,
                  width: 100.0,
                  onPressed: () {
                    navigateToLogin(context);
                    print('Clicked, login');
                  },
                  color: Colors.white,
                  title: 'Login',
                ),
                LoginButton(
                  height: 15.0,
                  width: 100.0,
                  onPressed: () {
                    navigateToSignUp(context);
                    print('Clicked sign up');
                  },
                  color: Colors.white,
                  title: 'Sign up',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}