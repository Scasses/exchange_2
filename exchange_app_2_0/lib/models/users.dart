import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String userName;
  final String uid;
  final String quote;
  final String name;
  final List audience;
  final List following;
  final double logic;
  final double eq;

  const Users(
      {required this.email,
        required this.userName,
        required this.uid,
        required this.quote,
        required this.name,
        required this.audience,
        required this.following,
        required this.logic,
        required this.eq});

  Map<String, dynamic> toJson() => {
    "email": email,
    "userName": userName,
    "uid": uid,
    "quote": quote,
    "name": name,
    "audience": audience,
    "following": following,
  };

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
      email: snapshot['email'],
      userName: snapshot['userName'],
      uid: snapshot['uid'],
      quote: snapshot['quote'],
      name: snapshot['name'],
      audience: snapshot['audience'],
      following: snapshot['following'],
      logic: snapshot['logic'],
      eq: snapshot['eq'],
    );
  }
}