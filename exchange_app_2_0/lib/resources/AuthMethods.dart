import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exchange_app_2_0/models/users.dart' as model;
import 'package:exchange_app_2_0/models/reply.dart' as model2;
import '../models/users.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../screens/login.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  //Get user details
  Future<Users> getUserDetails() async {
      // model.User currentUser = _auth.currentUser!;
      Users currentUser = _auth.currentUser! as model.Users;

      DocumentSnapshot snap =
      await _firestore.collection('users').doc(currentUser.uid).get();

      return model.Users.fromSnap(snap);
    }

  //Sign-up method
  Future<String> signUpUser(
      {required String email,
        required String password,
        required String userName,
        required String name,
        required String quote, required BuildContext context}) async {
    String response = 'Unfortunately an error has occured.';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          name.isNotEmpty ||
          quote.isNotEmpty) {
        //Register the user
        UserCredential credentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.Users user = model.Users(
          email: email,
          userName: userName,
          uid: credentials.user!.uid,
          quote: quote,
          name: '',
          audience: [],
          following: [],
          logic: 0,
          eq: 0,
        );

        //add user to database
        await _firestore
            .collection('users')
            .doc(credentials.user!.uid)
            .set(user.toJson());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => ResponsiveLayout(
                webScreenLayout: const WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )),
        );

        response = 'Success';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid email') {
        response = 'Please check your email, let\'s be sure it\'s valid.';
      } else if (error.code == 'weak-password') {
        response =
        'OK this is a bit embarrassing, apparently your password is kinda weak... let\'s try and be a bit stronger.';
      }
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //Logging in the user
  Future<String> loginUser(
      {required String email,
        required String password,
        required BuildContext context}) async {
    String response =
        "Hmm... I\'m not syaing that your email or your password is sketchy buuuut....";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        response = 'Success, welcome';
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              )),
        );
        print('${response} phase 1');
      } else {
        response = 'I know it\'s a chore but, please, fill in all fields.';
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        response =
        "Alright, a bit of an existential crisis, there is no such user in our records.";
      } else if (error.code == "wrong-password") {
        response =
        "Well we definitely know that the issue is your password, let\'s re-enter it.";
      }
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  // Future<void> signOut() async {
  //   try {
  //     await _auth.signOut();
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      //Navigate to login screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } catch (error) {
      print(error.toString());
    }
  }
}